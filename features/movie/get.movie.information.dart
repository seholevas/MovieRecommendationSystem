import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:recommend/core/errors/failure.interface.dart';
import 'package:recommend/core/usecase/usecase.interface.dart';
import 'package:recommend/features/movie/movie.entity.dart';
import 'package:recommend/features/movie/movie.repository.dart';

class GetMovieInformation implements UseCase<Movie, Params> {
  final MovieRepository repository;

  GetMovieInformation(this.repository);

  @override
  Future<Either<Failure, Movie>> call(Params params) async {
    return await repository.getMovieInformation(params.id);
  }
}

class Params extends Equatable {
  final int id;
  Params({@required this.id});

  @override
  List<Object> get props => [id];
}
