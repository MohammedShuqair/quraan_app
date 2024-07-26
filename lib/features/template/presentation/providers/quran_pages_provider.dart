import 'package:flutter/material.dart';
import 'package:tt9_quraan_app/core/constants/constants.dart';
import 'package:tt9_quraan_app/features/template/business/usecases/get_ayas.dart';
import 'package:tt9_quraan_app/features/template/data/datasources/aya_asset_data_source.dart';
import 'package:tt9_quraan_app/features/template/data/repositories/aya_repository_impl.dart';
import '../../../../../core/errors/failures.dart';

class QuranPagesProvider extends ChangeNotifier {
  List<QPage>? quranPages;
  Failure? failure;

  QuranPagesProvider({
    this.quranPages,
    this.failure,
  });

  bool readyToDisplay() {
    return quranPages?.isNotEmpty ?? false;
  }

  void eitherFailureOrQuranPages() async {
    QuranPageRepositoryImpl repository = QuranPageRepositoryImpl(
      assetDataSource: AyaAssetDataSourceImpl(),
    );

    final failureOrQuranPage =
        await GetQuranPages(ayaRepository: repository).call();

    await Future.delayed(const Duration(milliseconds: 100));

    failureOrQuranPage.fold(
      (Failure newFailure) {
        quranPages = null;
        failure = newFailure;
        notifyListeners();
      },
      (List<QPage> newQuranPage) {
        quranPages = newQuranPage;
        failure = null;
        notifyListeners();
      },
    );
    print("notifyed ${quranPages?.length} message ${failure?.message}");
  }
}
