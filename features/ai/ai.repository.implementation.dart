import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:recommend/features/ai/ai.entity.dart';
import 'package:recommend/features/ai/ai.remote.datasource.dart';
import 'package:recommend/features/ai/ai.repository.dart';
import 'package:recommend/core/errors/client.exception.dart';
import 'package:recommend/core/errors/client.failure.dart';
import 'package:recommend/core/errors/failure.interface.dart';
import 'package:recommend/core/errors/server.exception.dart';
import 'package:recommend/core/errors/server.failure.dart';


class KNNRepositoryImplementation implements KNNRepository
{
  final KNNRemoteDataSource remoteDataSource;

  KNNRepositoryImplementation({
    @required this.remoteDataSource});


  @override
  Future<Either<Failure, KNN>> getSuggestions(int movieId, int nSuggestions) 
  async {
    try {

    return Right(await remoteDataSource.getSuggestions(movieId, nSuggestions));

    }
    on ClientException
    {
      return Left(ClientFailure());
    }
    on ServerException
    {
      return Left(ServerFailure());
    }

  }  
}