// import 'package:dartz/dartz.dart';

import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:recommend/core/errors/client.exception.dart';
import 'package:recommend/core/errors/client.failure.dart';
import 'package:recommend/core/errors/failure.interface.dart';
import 'package:recommend/core/errors/server.exception.dart';
import 'package:recommend/core/errors/server.failure.dart';
import 'package:recommend/features/user/user.entity.dart';
import 'package:recommend/features/user/user.remote.datasource.dart';
import 'package:recommend/features/user/user.repository.dart';

class UserRepositoryImplementation implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImplementation({
    @required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, User>> getUserInformation() async {
    try {
      return Right(await remoteDataSource.getUserInformation());
    } on ClientException {
      return Left(ClientFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> createAccount(
      Map<String, dynamic> dictionary) async {
    try {
      return Right(await remoteDataSource.createAccount(dictionary));
    } on ClientException {
      return Left(ClientFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> signIn(Map<String, dynamic> dictionary) async {
    try {
      return Right(await remoteDataSource.signIn(dictionary));
    } on ClientException {
      return Left(ClientFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
