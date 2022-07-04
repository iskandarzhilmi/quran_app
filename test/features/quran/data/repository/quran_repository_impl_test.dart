import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_hive/core/error/exception.dart';
import 'package:learn_hive/core/platform/network_info.dart';
import 'package:learn_hive/features/quran/data/datasources/quran_local_data_source.dart';
import 'package:learn_hive/features/quran/data/datasources/quran_remote_data_source.dart';
import 'package:learn_hive/features/quran/data/models/quran_model.dart';
import 'package:learn_hive/features/quran/data/repositories/quran_repository_impl.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockRemoteDataSource extends Mock implements QuranRemoteDataSource {}

class MockLocalDataSource extends Mock implements QuranLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late QuranRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

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

  group('device is online', () {
    final tNumber = 1;
    final tQuranModel =
        QuranModel.fromJson(json.decode(fixture('trivia.json')));

    // This setUp applies only to the 'device is online' group
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    });

    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.getQuran(tNumber))
            .thenAnswer((_) async => tQuranModel);
        // act
        final result = await repository.getQuran(tNumber);
        // assert
        verify(mockRemoteDataSource.getQuran(tNumber));
        expect(result, equals(Right(tQuran)));
      },
    );

    test(
      'should return server failure when the call to remote data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.getQuran(tNumber))
            .thenThrow(ServerException());
        // act
        final result = await repository.getQuran(tNumber);
        // assert
        verify(mockRemoteDataSource.getQuran(tNumber));
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      },
    );
  });

  group('device is offline', () {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
    });

    test(
      'should return last locally cached data when the cached data is present',
      () async {
        // arrange
        when(mockLocalDataSource.getLastQuran())
            .thenAnswer((_) async => tQuranModel);
        // act
        final result = await repository.getConcreteQuran(tNumber);
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastQuran());
        expect(result, equals(Right(tQuran)));
      },
    );
  });
}
