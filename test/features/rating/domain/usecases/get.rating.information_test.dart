import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:recommend/production/features/rating/domain/entities/rating.entity.dart';
import 'package:recommend/production/features/rating/domain/repositories-abstractions/rating.repository.dart';
import 'package:recommend/production/features/rating/domain/usecases/get.rating.information.dart';

class MockRatingRepository extends Mock implements RatingRepository {}

void main() {
  GetRatingInformation usecase;
  MockRatingRepository mockRatingRepository;

  setUp(() {
    mockRatingRepository = MockRatingRepository();
    usecase = GetRatingInformation(mockRatingRepository);
  });
  final tUuid = "asdjfsdkffj";
  final tMovieId = 3;
  final tRating = Rating(movieId: 1, userId: 1, rating: 4, selectedByAI: true);

  test(
    'should get rating for the movie with the movie id from the rating repository',
    () async {
      // "On the fly" implementation of the Repository using the Mockito package.
      // When it is called with any argument, always answer with
      // the Right "side" of Either containing a test object of type Rating.
      when(mockRatingRepository.retrieveMovieRating(any))
          .thenAnswer((_) async => Right(tRating));
      // The "act" phase of the test. Call the not-yet-existent method.
      final result = await usecase.call(Params(movieId: tMovieId));
      // UseCase should simply return whatever was returned from the Repository
      expect(result, Right(tRating));
      // Verify that the method has been called on the Repository
      verify(mockRatingRepository.retrieveMovieRating(tMovieId));
      // Only the above method should be called and nothing more.
      verifyNoMoreInteractions(mockRatingRepository);
    },
  );
}
