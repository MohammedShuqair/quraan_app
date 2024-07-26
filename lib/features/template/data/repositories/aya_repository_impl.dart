import 'package:dartz/dartz.dart';
import 'package:tt9_quraan_app/core/constants/constants.dart';
import 'package:tt9_quraan_app/features/template/business/entities/Aya_entity.dart';
import 'package:tt9_quraan_app/features/template/business/entities/sura_entity.dart';
import 'package:tt9_quraan_app/features/template/data/datasources/aya_asset_data_source.dart';

import '../../../../../core/errors/failures.dart';
import '../../business/repositories/quran_page_repository.dart';

class QuranPageRepositoryImpl implements QuranPageRepository {
  final AyaAssetDataSource assetDataSource;

  QuranPageRepositoryImpl({
    required this.assetDataSource,
  });

  @override
  Future<Either<Failure, List<QPage>>> getQuranPages() async {
    try {
      List<QPage> pages = [];
      List<AyaEntity> quranAyas = await assetDataSource.getAyas();
      List<AyaEntity> quranPage = [];

      int currentPage = 1;
      while (pages.length < 604) {
        if (quranAyas.isNotEmpty && quranAyas[0].page == currentPage) {
          quranPage.add(quranAyas[0]);
          quranAyas.removeAt(0);
        } else {
          //know quranPage is full
          //1- parse it into List<Sura> (QPage) to add it into our pages var
          //2- clear quranPage data
          //3- go to next page currentPage++;

          List<SuraLine> suraLine = [];
          bool isLineFull = false;
          int currentLine = 0;
          while (quranPage.isNotEmpty) {
            if (quranPage[0].ayaText?.contains("\n") ?? false) {
              List<AyaEntity> separatedAya = quranPage[0].divide();
              while (separatedAya.isNotEmpty) {
                if (separatedAya.first.ayaTextView?.isNotEmpty ?? false) {
                  suraLine[currentLine].add(separatedAya.first);
                }
                if (separatedAya.length > 1 &&
                    (separatedAya.first.ayaTextView?.isNotEmpty ?? false)) {
                  currentLine++;
                }
                separatedAya.removeAt(0);
              }
            } else {
              suraLine[currentLine].add(quranPage[0]);
            }
          }
          //1
          List<SuraEntity> suras = [];

          for (int i = 0; i < quranPage.length; i++) {
            if (!isLineFull) {
              if (quranPage[i].ayaText?.contains("\n") ?? false) {
                List<AyaEntity> separatedAya = quranPage[i].divide();
                suraLine[0].add(separatedAya.first);
                isLineFull = true;
              } else {
                suraLine[0].add(quranPage[i]);
              }
            } else {
              if (!suras.any((sura) => sura.suraNo == quranPage[i].suraNo)) {
                suras.add(SuraEntity(
                  sura: [quranPage[i]],
                  suraNo: quranPage[i].suraNo,
                  suraNameAr: quranPage[i].suraNameAr,
                  suraNameEn: quranPage[i].suraNameEn,
                ));
              } else {
                //know there is sura in suras match i th ayas' sura
                suras
                    .singleWhere((sura) => sura.suraNo == quranPage[i].suraNo)
                    .sura
                    .add(quranPage[i]);
              }
              isLineFull = false;
              suraLine.clear();
            }
          }
          pages.add(suras);
          // 2
          quranPage.clear();
          //3
          currentPage++;
        }
      }
      return Right(pages);
    } catch (e) {
      return Left(AssetFailure(e.toString()));
    }
  }
}
