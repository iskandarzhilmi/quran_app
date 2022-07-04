import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/quran.dart';
import '../../domain/repositories/quran_repository.dart';
import '../datasources/quran_local_data_source.dart';
import '../datasources/quran_remote_data_source.dart';

class QuranRepositoryImpl implements QuranRepository {
  final QuranRemoteDataSource remoteDataSource;
  final QuranLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  QuranRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Quran>> getQuran(int page) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteQuran = await remoteDataSource.getQuran(page);
        localDataSource.cacheQuran(remoteQuran);
        return Right(remoteQuran);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localQuran = await localDataSource.getLastQuran();
        return Right(localQuran);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
