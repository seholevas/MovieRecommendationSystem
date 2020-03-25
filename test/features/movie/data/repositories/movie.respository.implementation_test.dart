import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:recommend/core/network/instance.network.information.dart';
import 'package:recommend/production/features/genre/domain/entity/genre.entity.dart';
import 'package:recommend/production/features/movie/data/models/movie.model.dart';
import 'package:recommend/production/features/movie/data/remote-data-sources/movie.remote.datasource.dart';
import 'package:recommend/production/features/movie/data/repositories-implementation/movie.repository.implementation.dart';
import 'package:recommend/production/features/movie/domain/entities/movie.entity.dart';

class MockRemoteDataSource extends Mock
    implements MovieRemoteDataSource {}

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

  group('getMovieInformation', () {
  // DATA FOR THE MOCKS AND ASSERTIONS
  final tId = 1;
  final tTitle = "";
  final tTagline = '';
  final tOverview = '';
  final tVoteCount = 1;
  final tVoteAverage = 1;
  final tPosterPath = "skjfsjfkskfl.jpg";
  final tGenreList = [Genre(id: 1, name: 'hello'), Genre(id: 32, name: "hithere")];
  final tMovieModel = MovieModel(id: tId, title: tTitle, tagline: tTagline, overview: tOverview, vote_count: tVoteCount, vote_average: tVoteAverage, genres: tGenreList, posterPath: tPosterPath);
  final Movie tMovie = tMovieModel;


  test('should check if the device is online', () {
    //arrange
    when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    // act
    repository.getMovieInformation(tId);
    // assert
    verify(mockNetworkInfo.isConnected);
  });
});
}