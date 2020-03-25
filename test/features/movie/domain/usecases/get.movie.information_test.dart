import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:recommend/production/features/genre/domain/entity/genre.entity.dart';
import 'package:recommend/production/features/movie/domain/entities/movie.entity.dart';
import 'package:recommend/production/features/movie/domain/repositories-abstractions/movie.repository.dart';
import 'package:recommend/production/features/movie/domain/usecases/get.movie.information.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  GetMovieInformation usecase;
  MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetMovieInformation(mockMovieRepository);
  });

  final tNumber = 1;
  final tMovie = Movie(
      id: 1,
      tagline: "test",
      overview: "testing",
      title: "Testers: Gone Debuggin",
      vote_count: 300,
      vote_average: 4,
      posterPath: "adjsfksjdkfl.jpg",
      genres: [Genre(id: 32, name: "hello"), Genre(id: 323, name: "world")]);

  test(
    'should get movie with the matching movie id from the movie repository',
    () async {
      // "On the fly" implementation of the Repository using the Mockito package.
      // When getConcreteNumberTrivia is called with any argument, always answer with
      // the Right "side" of Either containing a test NumberTrivia object.
      when(mockMovieRepository.getMovieInformation(any))
          .thenAnswer((_) async => Right(tMovie));
      // The "act" phase of the test. Call the not-yet-existent method.
      final result = await usecase.call(Params(id: tNumber));
      // UseCase should simply return whatever was returned from the Repository
      expect(result, Right(tMovie));
      // Verify that the method has been called on the Repository
      verify(mockMovieRepository.getMovieInformation(tNumber));
      // Only the above method should be called and nothing more.
      verifyNoMoreInteractions(mockMovieRepository);
    },
  );
}
