import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:recommend/core/usecase/usecase.interface.dart';
import 'package:recommend/features/movie/movie.entity.dart';
import 'package:recommend/features/movie/movie.repository.dart';
import 'package:recommend/core/errors/failure.interface.dart';

class GetAllMoviesInformation implements UseCase<List<Movie>, Params> {
  final MovieRepository repository;

  GetAllMoviesInformation(this.repository);

  @override
  Future<Either<Failure, List<Movie>>> call(Params params) async {
    return await repository.getMultipleMoviesInformation(params.movieIds);
  }
}

class Params extends Equatable {
  final List<int> movieIds;
  Params({@required this.movieIds});

  @override
  List<Object> get props => [id];
}
