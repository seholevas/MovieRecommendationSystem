import 'dart:convert';
import 'dart:io';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:http/http.dart' as http;
import 'package:recommend/core/errors/server.exception.dart';
import 'package:recommend/core/errors/client.exception.dart';
import 'package:recommend/production/features/movie/data/models/movie.model.dart';
import 'package:recommend/production/features/movie/data/remote-data-sources/movie.remote.datasource.dart';

import '../../../../fixtures/fixture.reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  MovieRemoteDataSourceImplementation dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = MovieRemoteDataSourceImplementation(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('movie.json'), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'} ));

  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  void setUpMockHttpClientFailure500() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 500));
  }

  group('getMovieInformation', () {
    final tNumber = 864;
    final tMovieModel = MovieModel.fromJson(json.decode(fixture('movie.json')));

    test(
      '''should perform a GET request on a URL with Movie ID
       being the endpoint and with application/json header''',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        dataSource.getMovieInformation(tNumber);
        // assert
        verify(mockHttpClient.get(
      "https://api.themoviedb.org/3/movie/$tNumber?&api_key=cfe422613b250f702980a3bbf9e90716",
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
      },
    ));
      },
    );

    test(
      'should return a Movie when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final result = await dataSource.getMovieInformation(tNumber);
        // assert
        expect(result, equals(tMovieModel));
      },
    );

    test(
      'should throw a ClientException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource.getMovieInformation;
        // assert
        expect(() => call(tNumber), throwsA(TypeMatcher<ClientException>()));
      },
    );


    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure500();
        // act
        final call = dataSource.getMovieInformation;
        // assert
        expect(() => call(tNumber), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });
}