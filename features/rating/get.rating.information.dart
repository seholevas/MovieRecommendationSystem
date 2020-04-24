import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:recommend/core/errors/failure.interface.dart';
import 'package:recommend/core/usecase/usecase.interface.dart';
import 'package:recommend/features/rating/rating.entity.dart';
import 'package:recommend/features/rating/rating.repository.dart';

class GetRatingInformation implements UseCase<Rating, Params> {
  final RatingRepository repository;

  GetRatingInformation(this.repository);

  @override
  Future<Either<Failure, Rating>> call(Params params) async {
    return await repository.retrieveMovieRating(params.movieId);
  }
}

class Params extends Equatable {
  final int movieId;
  Params({@required this.movieId});

  @override
  List<Object> get props => [movieId];
}
