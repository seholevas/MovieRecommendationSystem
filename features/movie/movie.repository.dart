import 'package:dartz/dartz.dart';
import 'package:recommend/features/movie/movie.entity.dart';
import 'package:recommend/core/errors/failure.interface.dart';

abstract class MovieRepository
{
  Future<Either<Failure, Movie>> getMovieInformation(int id);
  Future<Either<Failure, List<Movie>>> getMultipleMoviesInformation(List<int> movieIds);
  }
