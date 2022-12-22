import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:number_trivia/core/error/failures.dart';
import 'package:number_trivia/core/usecases/usecases.dart';
import 'package:number_trivia/core/util/input_converter.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/presentation/bloc/bloc.dart';

import '../../../../../.fvm/flutter_sdk/dev/bots/test/common.dart';

class MockGetConcreteNumberTrivia extends Mock
    implements GetConcreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockInputConvertor extends Mock implements InputConvertor {}

class MockParams extends Mock implements Params {}

class MockNoParams extends Mock implements NoParams {}

void main() {
  late NumberTriviaBloc bloc;
  late MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  late MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  late MockInputConvertor mockInputConvertor;
  const tNumberParsed = 1;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConvertor = MockInputConvertor();
    bloc = NumberTriviaBloc(
        getConcreteNumberTrivia: mockGetConcreteNumberTrivia,
        getRandomNumberTrivia: mockGetRandomNumberTrivia,
        inputConverter: mockInputConvertor);
    registerFallbackValue(MockParams());
    registerFallbackValue(MockNoParams());
  });

  void setUpInputConvertor() {
    when(() => mockInputConvertor.stringToUnsigned(any()))
        .thenReturn(const Right(tNumberParsed));
  }

  test(
      'test for Initial State should be Empty',
      () => {
            //assert
            expect(bloc.initialState, Empty())
          });

  group('GetTriviaForConcreteNumber', () {
    const tNumberString = "1";
    const tNumberTrivia = NumberTrivia(number: 1, text: "Text test");

    test(
        'should call InputConvertor to validate and convert the String to an unsigned integer',
        () async {
      //arrange
      setUpInputConvertor();
      when(() => mockGetConcreteNumberTrivia(any()))
          .thenAnswer((_) async => const Right(tNumberTrivia));
      //act
      bloc.add(const GetTriviaForConcreteNumber(tNumberString));
      await untilCalled(() => mockInputConvertor.stringToUnsigned(any()));

      //assert
      verify(() => mockInputConvertor.stringToUnsigned(tNumberString));
    });

    test("should emit [Error] when the input is invalid", () async {
      // arrange
      when(() => mockInputConvertor.stringToUnsigned(any()))
          .thenReturn(Left(InvalidInputFailure()));
      // assert later
      final expected = [
        Loading(),
        const Error(message: INVALID_INPUT_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(const GetTriviaForConcreteNumber(tNumberString));
    });

    test('should get data from the concrete usecase', () async {
      //arrange
      setUpInputConvertor();
      when(() => mockGetConcreteNumberTrivia(any()))
          .thenAnswer((_) async => const Right(tNumberTrivia));
      //act
      bloc.add(const GetTriviaForConcreteNumber(tNumberString));
      await untilCalled(() => mockGetConcreteNumberTrivia(any()));
      //assert
      verify(
          () => mockGetConcreteNumberTrivia(const Params(num: tNumberParsed)));
    });

    test('should emit [Loading], [Loaded] when we get data successfully',
        () async {
      //arrange
      setUpInputConvertor();
      when(() => mockGetConcreteNumberTrivia(any()))
          .thenAnswer((_) async => const Right(tNumberTrivia));
      // assert later
      final expected = [Loading(), const Loaded(trivia: tNumberTrivia)];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(const GetTriviaForConcreteNumber(tNumberString));
    });

    test('should emit [Loading], [Loaded] when loading data fails', () async {
      //arrange
      setUpInputConvertor();
      when(() => mockGetConcreteNumberTrivia(any()))
          .thenAnswer((_) async => Left(ServerFailure()));
      // assert later
      final expected = [
        Loading(),
        const Error(message: SERVER_FAILURE_MESSAGE)
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(const GetTriviaForConcreteNumber(tNumberString));
    });

    test('''should emit [Loading], [Loaded] when loading data '
        fails with proper message for the error''', () async {
      //arrange
      setUpInputConvertor();
      when(() => mockGetConcreteNumberTrivia(any()))
          .thenAnswer((_) async => Left(CacheFailure()));
      // assert later
      final expected = [Loading(), const Error(message: CACHE_FAILURE_MESSAGE)];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(const GetTriviaForConcreteNumber(tNumberString));
    });
  });

  group('GetTriviaForRandomNumber', () {
    const tNumberTrivia = NumberTrivia(number: 1, text: "Text test");

    test('should get data from the random usecase', () async {
      //arrange
      when(() => mockGetRandomNumberTrivia(NoParams()))
          .thenAnswer((_) async => const Right(tNumberTrivia));
      //act
      bloc.add(GetTriviaForRandomNumber());
      await untilCalled(() => mockGetRandomNumberTrivia(any()));
      //assert
      verify(() => mockGetRandomNumberTrivia(NoParams()));
    });

    test('should emit [Loading], [Loaded] when we get data successfully',
        () async {
      //arrange
      setUpInputConvertor();
      when(() => mockGetRandomNumberTrivia(any()))
          .thenAnswer((_) async => const Right(tNumberTrivia));
      // assert later
      final expected = [Loading(), const Loaded(trivia: tNumberTrivia)];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(GetTriviaForRandomNumber());
    });

    test('should emit [Loading], [Loaded] when loading data fails', () async {
      //arrange
      setUpInputConvertor();
      when(() => mockGetRandomNumberTrivia(any()))
          .thenAnswer((_) async => Left(ServerFailure()));
      // assert later
      final expected = [
        Loading(),
        const Error(message: SERVER_FAILURE_MESSAGE)
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(GetTriviaForRandomNumber());
    });

    test('''should emit [Loading], [Loaded] when loading data '
        fails with proper message for the error''', () async {
      //arrange
      setUpInputConvertor();
      when(() => mockGetRandomNumberTrivia(any()))
          .thenAnswer((_) async => Left(CacheFailure()));
      // assert later
      final expected = [Loading(), const Error(message: CACHE_FAILURE_MESSAGE)];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(GetTriviaForRandomNumber());
    });
  });
}
