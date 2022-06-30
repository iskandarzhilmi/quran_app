import 'package:equatable/equatable.dart';

class Quran extends Equatable {
  final String text;

  Quran({
    required this.text,
  });

  @override
  List<Object?> get props => [text];
}
