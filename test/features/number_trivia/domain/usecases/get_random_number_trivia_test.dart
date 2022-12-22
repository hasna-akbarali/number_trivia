import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:number_trivia/core/usecases/usecases.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  GetRandomNumberTrivia usecase;
  MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetRandomNumberTrivia(mockNumberTriviaRepository);
  });

  mockNumberTriviaRepository = MockNumberTriviaRepository();
  usecase = GetRandomNumberTrivia(mockNumberTriviaRepository);
  const tNumberTrivia = NumberTrivia(text: 'Successfully Tested', number: 1);

  test('should get trivia from the repository', () async {
    //arrange
    when(() => mockNumberTriviaRepository.getRandomNumberTrivia())
        .thenAnswer((_) async => const Right(tNumberTrivia));
    //act
    final result = await usecase(NoParams());

    //assert
    expect(result, const Right(tNumberTrivia));

    // verify that the method has been called on the repository
    verify(() => mockNumberTriviaRepository.getRandomNumberTrivia());

    // make sure no more interactions are happening with the repository
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}
