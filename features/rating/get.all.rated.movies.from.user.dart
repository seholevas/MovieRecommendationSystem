import 'package:dartz/dartz.dart';
import 'package:recommend/core/usecase/usecase.interface.dart';
import 'package:recommend/features/rating/rating.entity.dart';
import 'package:recommend/features/rating/rating.repository.dart';
import 'package:recommend/core/errors/failure.interface.dart';

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