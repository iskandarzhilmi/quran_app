import 'package:flutter_test/flutter_test.dart';
import 'package:learn_hive/features/quran/data/models/quran_model.dart';
import 'package:learn_hive/features/quran/domain/entities/quran.dart';

void main() {
  final tQuranModel = QuranModel(text: 'Test Text');

  test(
    'should be a subclass of NumberTrivia entity',
    () async {
      // assert
      expect(tQuranModel, isA<Quran>());
    },
  );
}
