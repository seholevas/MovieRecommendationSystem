import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:recommend/core/usecase/usecase.interface.dart';
import 'package:recommend/features/rating/rating.entity.dart';
import 'package:recommend/features/rating/rating.repository.dart';
import 'package:recommend/core/errors/failure.interface.dart';

class SubmitRatingInformation implements UseCase<Rating, Params>
{
  final RatingRepository repository;

  SubmitRatingInformation(this.repository);

  @override
  Future<Either<Failure, Rating>> call(Params params) async 
  {
    return await repository.submitMovieRating(params.dictionary);
  }

}

class Params extends Equatable
{
  final Map <String, dynamic> dictionary;
  Params({@required this.dictionary});

  @override
  List<Object> get props => [dictionary];
}