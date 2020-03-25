import 'dart:convert';
import 'dart:io';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:http/http.dart' as http;
import 'package:recommend/core/errors/server.exception.dart';
import 'package:recommend/core/errors/client.exception.dart';
import 'package:recommend/production/features/user/data/models/user.model.dart';
import 'package:recommend/production/features/user/data/remote-data-sources/user.remote.datasource.dart';
import '../../../../fixtures/fixture.reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  UserRemoteDataSourceImplementation dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = UserRemoteDataSourceImplementation(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(fixture('user.json'), 200, headers: {
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
            }));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  void setUpMockHttpClientFailure500() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 500));
  }

  group('getUserInformation', () {
    final tUUID = "digjvyBfMjOALVqs3CIsN5iUZXI3";
    final tUserModel = UserModel.fromJson(json.decode(fixture('user.json')));
    Map<String, String> requestHeaders = {
       'Content-type': 'application/json',
      //  'Accept': 'application/json',
      //  'Authorization': '<Your token>'
     };

    test(
      '''should perform a GET request on a URL with ID
       being the endpoint and with application/json header''',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        
        // act
        await dataSource.getUserInformation();
        // assert
        verify(mockHttpClient.get(
          // https://googlapi.herokuapp.com/database/read_user/$uuid
          "https://googlapi.herokuapp.com/firebase/database/user",
          headers: requestHeaders
          // {
            // HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
          // },
        ));
      },
    );

    test(
      'should return a User when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final result = await dataSource.getUserInformation();
        // assert
        expect(result, equals(tUserModel));
      },
    );

    test(
      'should throw a ClientException when the response code is 404',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource.getUserInformation;
        // assert
        expect(() => call(), throwsA(TypeMatcher<ClientException>()));
      },
    );

    test(
      'should throw a ServerException when the response code is 500',
      () async {
        // arrange
        setUpMockHttpClientFailure500();
        // act
        final call = dataSource.getUserInformation;
        // assert
        expect(() => call(), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });
}
