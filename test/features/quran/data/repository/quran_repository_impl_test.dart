import 'package:flutter_test/flutter_test.dart';
import 'package:learn_hive/core/platform/network_info.dart';
import 'package:learn_hive/features/quran/data/datasources/quran_local_data_source.dart';
import 'package:learn_hive/features/quran/data/repositories/quran_repository_impl.dart';
import 'package:mockito/mockito.dart';

class MockRemoteDataSource extends Mock implements QuranRemoteDataSource {}

class MockLocalDataSource extends Mock implements QuranLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  QuranRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = QuranRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });
}
