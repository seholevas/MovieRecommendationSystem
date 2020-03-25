
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:recommend/production/features/rating/data/models/rating.model.dart';
import 'package:recommend/production/features/rating/domain/entities/rating.entity.dart';
import 'package:recommend/production/features/rating/domain/repositories-abstractions/rating.repository.dart';
import '../../../../fixtures/fixture.reader.dart';

class MockRatingRepository extends Mock
    implements RatingRepository {}

void main() {
  final tRatingModel = RatingModel(userId: 3, movieId: 3, rating: 3.0, selectedByAI: true);
  
  test(
    'should get rating with the matching movie id and user id from the movie repository',
    () async {
      expect(tRatingModel, isA<Rating>());
    },
  );

  group('fromJson', () {
    test('should return a valid rating model when the JSON movie_id, and user_id are int', () 
    async{
      //arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture("rating.json"));
      //act
      final result = RatingModel.fromJson(jsonMap);
      //assert
      expect(result, tRatingModel);
    });
  });

  group('toJson', () {
  test(
    'should return a rating JSON map containing the proper data',
    () async {
      // act
      final result = tRatingModel.toJson();
      // assert
      final expectedJsonMap = {
        "user_id": "3",
      "movie_id":"3",
      "rating": "3.0",
      "selected_by_ai": "true"
      };
      expect(result, expectedJsonMap);
    },
  );
});
}