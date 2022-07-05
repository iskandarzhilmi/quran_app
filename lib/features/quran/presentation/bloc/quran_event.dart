part of 'quran_bloc.dart';

abstract class QuranEvent extends Equatable {
  const QuranEvent();

  @override
  List<Object?> get props => [];
}

class QuranPagePicked extends QuranEvent {
  const QuranPagePicked(this.page);
  final int page;

  @override
  List<Object?> get props => [page];
}
