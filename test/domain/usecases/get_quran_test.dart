import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_hive/features/quran/domain/entities/quran.dart';
import 'package:learn_hive/features/quran/domain/repositories/quran_repository.dart';
import 'package:learn_hive/features/quran/domain/usecases/get_quran.dart';
import 'package:mockito/mockito.dart';

class MockQuranRepository extends Mock implements QuranRepository {}

void main() {
  late GetQuran usecase;
  late MockQuranRepository mockQuranRepository;

  setUp(() {
    mockQuranRepository = MockQuranRepository();
    usecase = GetQuran(mockQuranRepository);
  });

  final tQuran = Quran(text: 'test');
  final tPageNumber = 3;

  test("should get quran from repository", () async {
    // arrange
    when(mockQuranRepository.getQuran(tPageNumber))
        .thenAnswer((_) async => Right(tQuran));
    // act
    final result = await usecase(Params(page: tPageNumber));
    // assert
    expect(result, equals(Right(tQuran.text)));
    // verify(mockQuranRepository.getQuranText(tPageNumber));
    // verifyNoMoreInteractions(mockQuranRepository);
  });
}
