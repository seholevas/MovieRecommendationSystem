import 'package:dartz/dartz.dart';
import 'package:recommend/core/errors/failure.interface.dart';
import 'package:recommend/features/ai/ai.entity.dart';

abstract class KNNRepository {
  // Future<Either<Failure,List<ArtificialIntelligenceKNN>>> getSuggestionsForMultipleMovies(List<int> movieId, int nSuggestions);
  Future<Either<Failure, KNN>> getSuggestions(int movieId, int nSuggestions);
}
