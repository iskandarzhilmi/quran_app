import 'package:meta/meta.dart';

import '../../domain/entities/quran.dart';

class QuranModel extends Quran {
  QuranModel({
    required String text,
  }) : super(
          text: text,
        );
}
