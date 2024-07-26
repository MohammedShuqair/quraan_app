import 'package:dartz/dartz.dart';
import 'package:tt9_quraan_app/core/constants/constants.dart';
import '../../../../../core/errors/failures.dart';

abstract class QuranPageRepository {
  Future<Either<Failure, List<QPage>>> getQuranPages();
}
