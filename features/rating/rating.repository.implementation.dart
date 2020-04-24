import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:recommend/core/errors/client.exception.dart';
import 'package:recommend/core/errors/client.failure.dart';
import 'package:recommend/core/errors/failure.interface.dart';
import 'package:recommend/core/errors/server.exception.dart';
import 'package:recommend/core/errors/server.failure.dart';
import 'package:recommend/features/rating/rating.entity.dart';
import 'package:recommend/features/rating/rating.remote.datasource.dart';
import 'package:recommend/features/rating/rating.repository.dart';

class RatingRepositoryImplementation implements RatingRepository {
  final RatingRemoteDataSource remoteDataSource;

  RatingRepositoryImplementation({@required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Rating>>> retrieveAllRatingsByUser() async {
    try {
      return Right(await remoteDataSource.getEveryRatingByUser());
    } on ClientException {
      return Left(ClientFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Rating>> retrieveMovieRating(int movieId) async {
    try {
      return Right(await remoteDataSource.getRatingInformation(movieId));
    } on ClientException {
      return Left(ClientFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Rating>> submitMovieRating(
      Map<String, dynamic> dictionary) async {
    try {
      return Right(await remoteDataSource.postRatingInformation(dictionary));
    } on ClientException {
      return Left(ClientFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
