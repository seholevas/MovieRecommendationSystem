import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:recommend/core/errors/client.exception.dart';
import 'package:recommend/core/errors/client.failure.dart';
import 'package:recommend/features/movie/movie.entity.dart';
import 'package:recommend/features/movie/movie.remote.datasource.dart';
import 'package:recommend/features/movie/movie.repository.dart';
import 'package:recommend/core/errors/failure.interface.dart';
import 'package:recommend/core/errors/server.exception.dart';
import 'package:recommend/core/errors/server.failure.dart';

class MovieRepositoryImplementation implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImplementation({@required this.remoteDataSource});

  @override
  Future<Either<Failure, Movie>> getMovieInformation(int id) async {
    try {
      return Right(await remoteDataSource.getMovieInformation(id));
    } on ClientException {
      return Left(ClientFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getMultipleMoviesInformation(
      List<int> movieIds) async {
    try {
      return Right(await remoteDataSource.getListOfMoviesInformation(movieIds));
    } on ClientException {
      return Left(ClientFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
