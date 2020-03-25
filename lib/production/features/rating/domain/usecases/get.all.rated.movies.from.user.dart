import 'package:dartz/dartz.dart';
import 'package:recommend/core/abstractions/usecase/usecase.interface.dart';
import 'package:recommend/production/features/rating/domain/entities/rating.entity.dart';
import 'package:recommend/core/errors/failure.interface.dart';
import 'package:recommend/production/features/rating/domain/repositories-abstractions/rating.repository.dart';

class GetAllMoviesUserRated implements UseCase<List<Rating>, NoParams>
{
  final RatingRepository repository;

  GetAllMoviesUserRated(this.repository);

  @override
  Future<Either<Failure, List<Rating>>> call(NoParams params) async 
  {
    return await repository.retrieveAllRatingsByUser();
  }

}