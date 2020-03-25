import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:recommend/production/features/ai/data/models/ai.model.dart';
import 'package:recommend/production/features/ai/domain/entities/ai.entity.dart';
import 'package:recommend/production/features/ai/domain/repositories-abstractions/ai.repository.dart';
import '../../../../fixtures/fixture.reader.dart';

class MockMovieRepository extends Mock
    implements ArtificialIntelligenceKNNRepository {}

void main() {
  final tAIModel = ArtificialIntelligenceKNNModel(suggestions: [3,2,1,1]);
  
  test(
    'should get movie with the matching movie id from the movie repository',
    () async {
      expect(tAIModel, isA<ArtificialIntelligenceKNN>());
    },
  );

  group('fromJson', () {
    test('should return a valid ai model when the JSON suggestions are doubles', () 
    async{
      //arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture("ai.json"));
      //act
      final result = ArtificialIntelligenceKNNModel.fromJson(jsonMap);
      //assert
      expect(result, equals(tAIModel));
    });
  });
}