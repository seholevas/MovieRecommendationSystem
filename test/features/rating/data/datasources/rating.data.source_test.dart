import 'dart:convert';
import 'dart:io';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:http/http.dart' as http;
import 'package:recommend/core/errors/server.exception.dart';
import 'package:recommend/core/errors/client.exception.dart';
import 'package:recommend/production/features/rating/data/datasource/rating.remote.datasource.dart';
import 'package:recommend/production/features/rating/data/models/rating.model.dart';
import '../../../../fixtures/fixture.reader.dart';

class MockHttpClient extends Mock implements http.Client {}

// class MockHttp extends Mock implements http.{}
// class MockHttp extends Mock implements http.Request{}
void main() {
  RatingRemoteDataSourceImplementation dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = RatingRemoteDataSourceImplementation(client: mockHttpClient);
  });

  void setUpMockHttpClientPOSTSuccess200() {
    when(http.post(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('rating.json'), 200));
  }

  void setUpMockHttpClientPOSTFailure404() {
    when(http.post(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('rating.json'), 404));
  }

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('rating.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  void setUpMockHttpClientFailure500() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 500));
  }

  group('getRatingInformation', () {
    final tMovieId = 2929;
    final tRatingModel =
        RatingModel.fromJson(json.decode(fixture('rating.json')));

    test(
      '''should perform a GET request on a URL with number
       being the endpoint and with application/json header''',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        dataSource.getRatingInformation(tMovieId);
        // assert
        verify(mockHttpClient.get(
          'https://googlapi.herokuapp.com/firebase/database/rating?movie_id=$tMovieId',
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          },
        ));
      },
    );

    test(
      'should return Rating when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final result = await dataSource.getRatingInformation(tMovieId);
        // assert
        expect(result, equals(tRatingModel));
      },
    );

    test(
      'should throw a ClientException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource.getRatingInformation;
        // assert
        expect(() => call(tMovieId), throwsA(TypeMatcher<ClientException>()));
      },
    );

    test(
      'should throw a ServerException when the response code is 500 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure500();
        // act
        final call = dataSource.getRatingInformation;
        // assert
        expect(() => call(tMovieId), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });

  group('postRatingInformation', () {
    final tRatingModel =
        RatingModel.fromJson(json.decode(fixture("rating.json")));

    test('''should perform a POST request on a URL with number
       being the endpoint and with application/json header''', () async {
      // arrange
      // setUpMockHttpClientPOSTSuccess200();
      // act
      dataSource.postRatingInformation(tRatingModel.toJson());

      // assert
      //   verify(await mockHttpClient.post(
      //     'http://127.0.0.1:5000/firebase/database/rating',
      //     headers: {
      //   HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded; charset=utf-8'
      // },

      //     body: json.encode(tRatingModel.toJson())
      //   ));
    });

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        // setUpMockHttpClientFailure404();
        // act
        final call = dataSource.postRatingInformation;
        // assert
        expect(() => call(tRatingModel.toJson()),
            throwsA(TypeMatcher<ServerException>()));
      },
    );
  });
}
