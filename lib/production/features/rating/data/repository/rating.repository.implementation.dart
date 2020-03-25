import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:recommend/core/errors/client.exception.dart';
import 'package:recommend/core/errors/client.failure.dart';
import 'package:recommend/core/errors/failure.interface.dart';
import 'package:recommend/core/errors/server.exception.dart';
import 'package:recommend/core/errors/server.failure.dart';
import 'package:recommend/core/network/instance.network.information.dart';
import 'package:recommend/production/features/rating/data/datasource/rating.remote.datasource.dart';
import 'package:recommend/production/features/rating/domain/entities/rating.entity.dart';
import 'package:recommend/production/features/rating/domain/repositories-abstractions/rating.repository.dart';

class RatingRepositoryImplementation implements RatingRepository {
  final RatingRemoteDataSource remoteDataSource;
  final NetworkInformation networkInformation;

  RatingRepositoryImplementation(
      {@required this.remoteDataSource, @required this.networkInformation});

  @override
  Future<Either<Failure, List<Rating>>> retrieveAllRatingsByUser() async {
    if(await networkInformation.isConnected)
    {
      try
      {
        return Right (await remoteDataSource.getEveryRatingByUser());
      } on ClientException {
        return Left(ClientFailure());
      } on ServerException {
        return Left(ServerFailure());
      } 
    }
  }

  @override
  Future<Either<Failure, Rating>> retrieveMovieRating(int movieId) async {
    if (await networkInformation.isConnected) {
      try {
        return Right(await remoteDataSource.getRatingInformation(movieId));
      } on ClientException {
        return Left(ClientFailure());
      } on ServerException {
        return Left(ServerFailure());
      }
    }
  }

    @override
    Future<Either<Failure, Rating>> submitMovieRating(Map<String, dynamic> dictionary) async {
      if (await networkInformation.isConnected) {
        try {
          return Right(await remoteDataSource.postRatingInformation(dictionary));
        } on ClientException {
          return Left(ClientFailure());
        } on ServerException {
          return Left(ServerFailure());
        }
      }
    }
  }

