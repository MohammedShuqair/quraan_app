import 'package:tt9_quraan_app/features/ayas_view/models/aya.dart';
import 'package:tt9_quraan_app/features/ayas_view/models/sura.dart';

import '../servises/asset.dart';

class PageRepo {
  Future<List<List<Sura>>> getAllPages() async {
    List<List<Sura>> pages = [];
    List<dynamic> quranData = await Asset().fetchAllData();
    List<Aya> quranAyas = quranData.map((e) => Aya.fromJson(e)).toList();
    List<Aya> quranPage = [];

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

        //1
        List<Sura> suras = [];

        for (int i = 0; i < quranPage.length; i++) {
          if (!suras.any((sura) => sura.suraNo == quranPage[i].suraNo)) {
            suras.add(Sura(
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
        }
        pages.add(suras);
        // 2
        quranPage.clear();
        //3
        currentPage++;
      }
    }

    return pages;
  }
}
