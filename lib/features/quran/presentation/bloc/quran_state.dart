part of 'quran_bloc.dart';

class QuranStateModel extends Equatable {
  final Quran quran;

  const QuranStateModel({required this.quran});

  @override
  // TODO: implement props
  List<Object?> get props => [quran];

  factory QuranStateModel.initial() {
    return QuranStateModel(
      quran: Quran(text: ''), //TODO: Betul ka ni?
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
