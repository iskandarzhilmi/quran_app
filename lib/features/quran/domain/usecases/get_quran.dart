import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:learn_hive/core/usecase.dart';
import 'package:learn_hive/quran.dart';

import '../../../../core/error/failures.dart';
import '../entities/quran.dart';
import '../repositories/quran_repository.dart';

class GetQuran extends UseCase<Quran, Params> {
  final QuranRepository repository;

  GetQuran(this.repository);

  Future<Either<Failure, Quran>> execute(int page) {
    return repository.getQuran(page);
  }

  @override
  Future<Either<Failure, Quran>> call(Params params) async {
    return await repository.getQuran(params.page);
  }
}

class Params extends Equatable {
  final int page;

  Params({required this.page});

  @override
  List<Object?> get props => [page];
}
