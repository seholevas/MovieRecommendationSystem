import 'package:dartz/dartz.dart';
import 'package:recommend/core/errors/failure.interface.dart';

class InputConverter {
  Either<Failure, int> stringToUnsignedInteger(String str) {
    try {
      var integer;
      if (str.contains(".")) {
        final doub = double.parse(str);
        integer = doub.toInt();
      } else {
        integer = int.parse(str);
      }

      if (integer < 0) throw FormatException();
      return Right(integer);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }

  Either<Failure, bool> stringToBoolean(String str) {
    if (str.toLowerCase() == "true") {
      return Right(true);
    } else if (str.toLowerCase() == "false") {
      return Right(false);
    } else {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {}
