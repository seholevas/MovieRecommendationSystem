import 'package:dartz/dartz.dart';
import 'package:recommend/core/errors/failure.interface.dart';
import 'package:recommend/features/user/user.entity.dart';

abstract class UserRepository
{
  Future<Either<Failure,User>> getUserInformation();
  Future<Either<Failure, User>> signIn(Map<String, dynamic> dictionary);
  Future<Either<Failure, User>> createAccount(Map<String, dynamic> dictionary);
}