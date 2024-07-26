import 'package:dartz/dartz.dart';
import 'package:tt9_quraan_app/core/constants/constants.dart';
import 'package:tt9_quraan_app/features/template/business/repositories/quran_page_repository.dart';

import '../../../../../core/errors/failures.dart';

class GetQuranPages {
  final QuranPageRepository ayaRepository;

  GetQuranPages({required this.ayaRepository});

  Future<Either<Failure, List<QPage>>> call() async {
    return await ayaRepository.getQuranPages();
  }
}
