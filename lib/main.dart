import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:learn_hive/features/quran/presentation/pages/quran_page.dart';
import 'package:learn_hive/quran.dart';

import 'features/quran/presentation/bloc/quran_bloc.dart';

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
    return BlocProvider(
      create: (context) => QuranBloc(),
      child: MaterialApp(
        title: 'Quran App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: QuranPage.id,
        routes: {
          QuranPage.id: (context) => const QuranPage(),
        },
      ),
    );
  }
}
