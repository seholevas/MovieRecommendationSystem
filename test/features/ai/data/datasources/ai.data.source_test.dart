import 'dart:convert';
import 'dart:io';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:http/http.dart' as http;
import 'package:recommend/core/errors/server.exception.dart';
import 'package:recommend/production/features/ai/data/models/ai.model.dart';
import 'package:recommend/production/features/ai/data/remote-data-sources/ai.remote.datasource.dart';

import '../../../../fixtures/fixture.reader.dart';


class MockHttpClient extends Mock implements http.Client {}

void main() {
  ArtificialIntelligenceKNNRemoteDataSourceImplementation dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = ArtificialIntelligenceKNNRemoteDataSourceImplementation(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('ai.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getSuggestions', () {
    final tId = 364;
    final tNumOfSuggestions = 4;
    final tAIModel =
        ArtificialIntelligenceKNNModel.fromJson(json.decode(fixture('ai.json')));

    test(
      '''should perform a GET request on a URL with number
       being the endpoint and with application/json header''',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        dataSource.getSuggestions(tId, tNumOfSuggestions);
        // assert
        verify(mockHttpClient.get( 
          'https://diamond-betty.herokuapp.com/$tId/$tNumOfSuggestions',
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          },
        ));
      },
    );

    test(
      'should return NumberTrivia when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final result = await dataSource.getSuggestions(tId, tNumOfSuggestions);
        // assert
        expect(result, equals(tAIModel));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource.getSuggestions;
        // assert
        expect(() => call(tId, tNumOfSuggestions), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });
}