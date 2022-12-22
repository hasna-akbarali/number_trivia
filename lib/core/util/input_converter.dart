import 'package:dartz/dartz.dart';

import '../error/failures.dart';

class InputConvertor {
  Either<Failure, int> stringToUnsigned(String str) {
    try {
      final result = int.parse(str);
      if (result < 0) {
        throw const FormatException();
      }
      return Right(result);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}
