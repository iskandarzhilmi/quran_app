import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/quran.dart';

abstract class QuranRepository {
  Future<Either<Failure, Quran>> getQuran(int page);
  // // Future<Either<Failure, Quran>> getRandomNumberTrivia();
}
