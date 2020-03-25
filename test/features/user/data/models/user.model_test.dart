
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:recommend/production/features/user/data/models/user.model.dart';
import 'package:recommend/production/features/user/domain/entities/user.entity.dart';
import 'package:recommend/production/features/user/domain/repositories-abstractions/user.repository.dart';
import '../../../../fixtures/fixture.reader.dart';

class MockUserRepository extends Mock
    implements UserRepository {}

void main() {
  final tUserModel = UserModel(userUID: "393", username: "tester", email: "test@test.com", password: "3803091!!!J", numUserId: 203039);
  
  test(
    'should get rating with the matching movie id and user id from the movie repository',
    () async {
      expect(tUserModel, isA<User>());
    },
  );

  group('fromJson', () {
    test('should return a valid rating model when the JSON movie_id, and user_id are int', () 
    async{
      //arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture("user.json"));
      //act
      final result = UserModel.fromJson(jsonMap);
      //assert
      expect(result, tUserModel);
    });
  });


  group('toJson', () {
  test(
    'should return a user JSON map containing the proper data',
    () async {
      // act
      final result = tUserModel.toJson();
      // assert
      final expectedJsonMap = {
        "user_id": "393",
      "username": "tester",
      "num_user_id": "203039",
      "email": "test@test.com",
      "password": "3803091!!!J",
      };
      expect(result, expectedJsonMap);
    },
  );
});

}