import 'package:equatable/equatable.dart';

abstract class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();

  @override
  List<Object> get props => [];
}

class GetTriviaForConcreteNumber extends NumberTriviaEvent {
  final String number;

  const GetTriviaForConcreteNumber(this.number);

  @override
  List<Object> get props => [number];
}

class GetTriviaForRandomNumber extends NumberTriviaEvent {}
