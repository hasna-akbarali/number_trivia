import 'package:dartz/dartz.dart';
import 'package:number_trivia/core/error/failures.dart';
import 'package:number_trivia/core/util/input_converter.dart';

import '../../../.fvm/flutter_sdk/dev/bots/test/common.dart';

void main() {
  late InputConvertor inputConvertor;

  setUp(() => inputConvertor = InputConvertor());

  group('stringToUnsignedInt', () {
    test(
        'should return an integer when the string represents an unsigned integer',
        () {
      //arrange
      const str = '123';
      //act
      final result = inputConvertor.stringToUnsigned(str);
      //assert
      expect(result, const Right(123));
    });

    test('should return failure when the string is not an integer', () {
      //arrange
      const str = 'abc';
      //act
      final result = inputConvertor.stringToUnsigned(str);
      //assert
      expect(result, Left(InvalidInputFailure()));
    });

    test('should return failure when the string is a negative integer', () {
      //arrange
      const str = 'abc';
      //act
      final result = inputConvertor.stringToUnsigned(str);
      //assert
      expect(result, Left(InvalidInputFailure()));
    });
  });
}
