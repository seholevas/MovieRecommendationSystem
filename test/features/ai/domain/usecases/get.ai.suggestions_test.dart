
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:recommend/production/features/ai/domain/entities/ai.entity.dart';
import 'package:recommend/production/features/ai/domain/repositories-abstractions/ai.repository.dart';
import 'package:recommend/production/features/ai/domain/usecases/get.ai.suggestions.dart';


class AIRepository extends Mock
    implements ArtificialIntelligenceKNNRepository {}

void main() {
  GetAISuggestions usecase;
  AIRepository mockAIRepository;

  setUp(() {
    mockAIRepository = AIRepository();
    usecase = GetAISuggestions(mockAIRepository);
  });

  final tMovieId = 403;
  final tN = 5;
  final tNSuggestions = [1,2,3,4,6];

  final tAI = ArtificialIntelligenceKNN(suggestions: tNSuggestions);
  test(
    'should get AI suggestsions for the movie id that was given from the repository',
    () async {
      // "On the fly" implementation of the Repository using the Mockito package.
      // When getConcreteNumberTrivia is called with any argument, always answer with
      // the Right "side" of Either containing a test NumberTrivia object.
      when(mockAIRepository.getSuggestions(any, any))
          .thenAnswer((_) async => Right(tAI));
      // The "act" phase of the test. Call the not-yet-existent method.
      final result = await usecase.call(Params(id: tMovieId, n_suggestions: tN));
      // UseCase should simply return whatever was returned from the Repository
      expect(result, Right(tAI));
      // Verify that the method has been called on the Repository
      verify(mockAIRepository.getSuggestions(tMovieId,tN));
      // Only the above method should be called and nothing more.
      verifyNoMoreInteractions(mockAIRepository);
    },
  );
}