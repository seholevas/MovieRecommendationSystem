import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recommend/core/errors/server.exception.dart';
import 'package:recommend/core/errors/server.failure.dart';
import 'package:recommend/core/network/instance.network.information.dart';
import 'package:recommend/production/features/ai/data/models/ai.model.dart';
import 'package:recommend/production/features/ai/data/remote-data-sources/ai.remote.datasource.dart';
import 'package:recommend/production/features/ai/data/repositories-implementation/ai.repository.implementation.dart';
import 'package:recommend/production/features/ai/domain/entities/ai.entity.dart';

class MockRemoteDataSource extends Mock
    implements ArtificialIntelligenceKNNRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInformation {}

void main() {
  ArtificialIntelligenceKNNRepositoryImplementation repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = ArtificialIntelligenceKNNRepositoryImplementation(
      remoteDataSource: mockRemoteDataSource,
      networkInformation: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getSuggestions', () {
    final tId = 369;
    final tNumberOfSuggestions = 5;
    final tSuggestions = [3, 2, 1];
    final tAIModel = ArtificialIntelligenceKNNModel(suggestions: tSuggestions);
    final ArtificialIntelligenceKNN tAI = tAIModel;

    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        repository.getSuggestions(tId, tNumberOfSuggestions);
        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getSuggestions(any, any))
              .thenAnswer((_) async => tAIModel);
          // act
          final result =
              await repository.getSuggestions(tId, tNumberOfSuggestions);
          // assert
          verify(
              mockRemoteDataSource.getSuggestions(tId, tNumberOfSuggestions));
          expect(result, equals(Right(tAI)));
        },
      );

      test(
        'should cache the data locally when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getSuggestions(any, any))
              .thenAnswer((_) async => tAIModel);
          // act
          await repository.getSuggestions(tId, tNumberOfSuggestions);
          // assert
          verify(
              mockRemoteDataSource.getSuggestions(tId, tNumberOfSuggestions));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockRemoteDataSource.getSuggestions(any, any))
              .thenThrow(ServerException());
          // act
          final result =
              await repository.getSuggestions(tId, tNumberOfSuggestions);
          // assert
          verify(
              mockRemoteDataSource.getSuggestions(tId, tNumberOfSuggestions));
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });
  });
}
