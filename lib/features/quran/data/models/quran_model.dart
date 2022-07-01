import 'package:meta/meta.dart';

import '../../domain/entities/quran.dart';

class QuranModel extends Quran {
  QuranModel({
    required String text,
  }) : super(
          text: text,
        );

  factory QuranModel.fromJson(Map<String, dynamic> json) {
    var data = json['result'];
    String pageText = '';
    for (int lineIndex = 0; lineIndex < data.length; lineIndex++) {
      String lineText = '';
      var lineType = data[lineIndex]['detail']['line_type'];
      if (lineType == 'start_sura') {
        lineText = data[lineIndex]['detail']['name'];
      } else if (lineType == 'besmellah') {
        lineText = 'بِسْمِ ٱللَّٰهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ';
      } else {
        lineText = '';
        for (int kalimahIndex = 0;
            kalimahIndex < (data[lineIndex]['word']).length;
            kalimahIndex++,) {
          var wordMap = data[lineIndex]['word'][kalimahIndex];
          if (wordMap['char_type'] == 'end') {
            lineText = lineText + ' ${wordMap['aya']} ';
          } else {
            lineText = lineText + ' ${wordMap['text']}';
          }
        }
      }
      if (lineIndex != 0) {
        pageText = pageText + '\n$lineText';
      } else {
        pageText = pageText + lineText;
      }
    }
    print(pageText);
    return QuranModel(text: pageText);
  }
}
