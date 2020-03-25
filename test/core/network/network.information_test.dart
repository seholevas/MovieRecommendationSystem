import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:recommend/core/network/instance.network.information.dart';
import 'package:recommend/production/features/genre/domain/entity/genre.entity.dart';
import 'package:recommend/production/features/movie/data/models/movie.model.dart';
import 'package:recommend/production/features/movie/data/remote-data-sources/movie.remote.datasource.dart';
import 'package:recommend/production/features/movie/data/repositories-implementation/movie.repository.implementation.dart';

class MockRemoteDataSource extends Mock implements MovieRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInformation {}

void main() {
  MovieRepositoryImplementation repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = MovieRepositoryImplementation(
      remoteDataSource: mockRemoteDataSource,
      networkInformation: mockNetworkInfo,
    );
  });

  group('device is online', () {
    // This setUp applies only to the 'device is online' group
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    });

    test(
      'should return remote data when the call to remote data source [using Movie] is successful',
      () async {
        // arrange
        final tId = 1;
        final tTitle = "";
        final tTagline = '';
        final tOverview = '';
        final tVoteCount = 1;
        final tVoteAverage = 1;
        final List<Genre> genres = [Genre(id: 32, name: 'comedy'), Genre(id: 3, name: "horror")];
        final tMovieModel = MovieModel(
            id: tId,
            title: tTitle,
            tagline: tTagline,
            overview: tOverview,
            vote_count: tVoteCount,
            vote_average: tVoteAverage,
            posterPath: "dfsksdjjf.jpg",
            genres: genres);
        final tMovie = tMovieModel;
        when(mockRemoteDataSource.getMovieInformation(tId))
            .thenAnswer((_) async => tMovieModel);
        // act
        final result = await repository.getMovieInformation(tId);
        // assert
        verify(mockRemoteDataSource.getMovieInformation(tId));
        expect(result, equals(Right(tMovie)));
      },
    );
  });
}
