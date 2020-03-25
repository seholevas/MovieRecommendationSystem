import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:recommend/core/abstractions/usecase/usecase.interface.dart';
import 'package:recommend/production/features/rating/domain/entities/rating.entity.dart';
import 'package:recommend/production/features/rating/domain/repositories-abstractions/rating.repository.dart';
import 'package:recommend/production/features/rating/domain/usecases/get.all.rated.movies.from.user.dart';

class MockRatingRepository extends Mock
    implements RatingRepository {}

void main() {
  GetAllMoviesUserRated usecase;
  MockRatingRepository mockRatingRepository;

  setUp(() {
    mockRatingRepository = MockRatingRepository();
    usecase = GetAllMoviesUserRated(mockRatingRepository);
  });
  final tRatingList = [Rating(movieId: 1,userId: 1, rating: 4, selectedByAI: false), Rating(movieId: 3, userId: 3, rating: 3, selectedByAI:  true)];

  test(
    'should get rating for the movie with the movie id from the rating repository',
    () async {
      // "On the fly" implementation of the Repository using the Mockito package.
      // When it is called with any argument, always answer with
      // the Right "side" of Either containing a test object of type Rating.
      when(mockRatingRepository.retrieveAllRatingsByUser())
          .thenAnswer((_) async => Right(tRatingList));
      // The "act" phase of the test. Call the not-yet-existent method.
      final result = await usecase.call(NoParams());
      // UseCase should simply return whatever was returned from the Repository
      expect(result, Right(tRatingList));
      // Verify that the method has been called on the Repository
      verify(mockRatingRepository.retrieveAllRatingsByUser());
      // Only the above method should be called and nothing more.
      verifyNoMoreInteractions(mockRatingRepository);
    },
  );
}