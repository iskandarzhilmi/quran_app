import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../quran.dart';
import '../bloc/quran_bloc.dart';

class QuranPage extends StatefulWidget {
  const QuranPage({Key? key}) : super(key: key);

  static String id = 'quran_page';

  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  String page = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quran by Page'),
      ),
      body: Center(
        child: BlocBuilder<QuranBloc, QuranStateModel>(
          builder: (context, state) {
            if (state.quranState is QuranLoading) {
              return FutureBuilder(
                future: getQuran(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Stack(
                      children: [
                        ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int lineIndex) {
                            String word = '';
                            // String detail = snapshot.data[index]['detail']['line_type'];
                            var lineType =
                                snapshot.data[lineIndex]['detail']['line_type'];
                            if (lineType == 'start_sura') {
                              word = snapshot.data[lineIndex]['detail']['name'];
                            } else if (lineType == 'besmellah') {
                              word = 'بِسْمِ ٱللَّٰهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ';
                            } else {
                              word = '';
                              for (int kalimahIndex = 0;
                                  kalimahIndex <
                                      (snapshot.data[lineIndex]['word']).length;
                                  kalimahIndex++,) {
                                var wordMap = snapshot.data[lineIndex]['word']
                                    [kalimahIndex];
                                if (wordMap['char_type'] == 'end') {
                                  word = word + ' ${wordMap['aya']} ';
                                } else {
                                  word = word + ' ${wordMap['text']}';
                                }
                              }
                            }
                            return Text(
                              word,
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.visible,
                              softWrap: true,
                              style: GoogleFonts.scheherazadeNew(
                                textStyle: TextStyle(
                                  height: 2.3,
                                  // color: Theme.of(context).primaryColor,
                                  // color: Colors.transparent,
                                  fontSize: 20,
                                ),
// ),
                              ),
                            );
                          },
                        ),
                        Positioned(
                          child: TextField(
                            onChanged: (value) {
                              setState(
                                () {
                                  page = value;
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
