import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:learn_hive/core/util/input_converter.dart';
import 'package:learn_hive/features/quran/data/models/quran_model.dart';
import 'package:learn_hive/features/quran/domain/repositories/quran_repository.dart';
import 'package:learn_hive/features/quran/domain/usecases/get_quran.dart';

import '../../domain/entities/quran.dart';

part 'quran_event.dart';
part 'quran_state.dart';

class QuranBloc extends Bloc<QuranEvent, QuranStateModel> {
  QuranBloc() : super(QuranStateModel.initial()) {
    // on<QuranEvent>((event, emit) {});
    on<QuranPagePicked>(_onQuranPagePicked);
  }

  _onQuranPagePicked(QuranPagePicked event, Emitter emit) async {
    try {
      // emit(
      //   state.copyWith(
      //     newQuranState: QuranLoading(),
      //   ),
      // );
      QuranRepository repository;
      emit(
        state.copyWith(
          newQuranState: QuranLoading(),
        ),
      );

      final page = event.page;
      // final response = await GetQuran();

      // final inputEither = InputConverter().jsonToQuranPage();
    } catch (e) {
      emit(
        state.copyWith(
          newQuranState: QuranError(message: 'Quran Load Failed.'),
        ),
      );
    }
  }
}
