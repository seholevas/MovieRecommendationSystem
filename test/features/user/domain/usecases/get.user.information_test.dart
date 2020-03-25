import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:recommend/core/abstractions/usecase/usecase.interface.dart';
import 'package:recommend/production/features/user/domain/entities/user.entity.dart';
import 'package:recommend/production/features/user/domain/repositories-abstractions/user.repository.dart';
import 'package:recommend/production/features/user/domain/usecases/get.user.information.dart';

class MockMovieRepository extends Mock
    implements UserRepository {}

void main() {
  GetUserInformation usecase;
  MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetUserInformation(mockMovieRepository);
  });

  final tUserName = "username";
  final tUserEmail = "test@mail.com";
  final tUserPassword = "password";
  final tUUID = "test";
  final tNumber_id = 1;

  final tUser = User(username: tUserName, email: tUserEmail, password: tUserPassword, userUID: tUUID, numUserId: tNumber_id);

  test(
    'should get user with the uuid given from the repository',
    () async {
      // "On the fly" implementation of the Repository using the Mockito package.
      // When getConcreteNumberTrivia is called with any argument, always answer with
      // the Right "side" of Either containing a test NumberTrivia object.
      when(mockMovieRepository.getUserInformation())
          .thenAnswer((_) async => Right(tUser));
      // The "act" phase of the test. Call the not-yet-existent method.
      final result = await usecase.call(NoParams());
      // UseCase should simply return whatever was returned from the Repository
      expect(result, Right(tUser));
      // Verify that the method has been called on the Repository
      verify(mockMovieRepository.getUserInformation());
      // Only the above method should be called and nothing more.
      verifyNoMoreInteractions(mockMovieRepository);
    },
  );
}