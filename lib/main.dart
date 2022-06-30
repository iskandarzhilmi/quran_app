import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:learn_hive/quran.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    saveTodo();
  }

  void saveTodo() async {
    var box = await Hive.openBox('testBox');
    box.put('name', 'David');

    print('Name: ${box.get('name')}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quran by Page'),
      ),
      body: Center(
        child: FutureBuilder(
          future: getQuran(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Stack(
                children: [
                  // Center(
                  //     child: Image.asset(
                  //   'assets/images/surahPage3.png',
                  //   // color: Colors.transparent,
                  // )),
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
                          var wordMap =
                              snapshot.data[lineIndex]['word'][kalimahIndex];
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
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
