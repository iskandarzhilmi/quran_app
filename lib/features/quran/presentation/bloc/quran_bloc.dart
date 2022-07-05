import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/quran.dart';

part 'quran_event.dart';
part 'quran_state.dart';

class QuranBloc extends Bloc<QuranEvent, QuranStateModel> {
  QuranBloc({required QuranPagePicked quranPagePicked})
      : super(QuranStateModel.initial()) {
    on<QuranEvent>((event, emit) {});
  }
}
