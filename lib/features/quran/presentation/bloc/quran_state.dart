part of 'quran_bloc.dart';

class QuranStateModel extends Equatable {
  final Quran quran;
  final QuranState quranState;

  const QuranStateModel({
    required this.quran,
    required this.quranState,
  });

  @override
  List<Object?> get props => [quran, quranState];

  QuranStateModel copyWith({
    Quran? newQuran,
    QuranState? newQuranState,
  }) {
    return QuranStateModel(
      quran: newQuran ?? quran,
      quranState: newQuranState ?? quranState,
    );
  }

  factory QuranStateModel.initial() {
    return QuranStateModel(
      //TODO: Betul ka ni?
      quran: Quran(text: ''),
      quranState: QuranLoading(),
    );
  }
}

abstract class QuranState extends Equatable {
  const QuranState();
  @override
  List<Object> get props => [];
}

class QuranLoaded extends QuranState {
  final Quran quran;

  QuranLoaded(this.quran);
}

class QuranLoading extends QuranState {}

class QuranEmpty extends QuranState {}

class QuranError extends QuranState {
  final String message;
  QuranError({required this.message});

  @override
  List<Object> get props => [message];
}
