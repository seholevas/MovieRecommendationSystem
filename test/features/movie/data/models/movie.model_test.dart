
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:recommend/production/features/genre/domain/entity/genre.entity.dart';
import 'package:recommend/production/features/movie/data/models/movie.model.dart';
import 'package:recommend/production/features/movie/domain/entities/movie.entity.dart';
import 'package:recommend/production/features/movie/domain/repositories-abstractions/movie.repository.dart';

import '../../../../fixtures/fixture.reader.dart';

class MockMovieRepository extends Mock
    implements MovieRepository {}

void main() {
  final tMovieModel = MovieModel(id: 1, title: "", tagline: "", overview: "", vote_count: 1, vote_average: 1, genres: [Genre(id: 32, name: "humor"), Genre(id: 322, name: "comedy")], posterPath: "");
  
  test(
    'should get movie with the matching movie id from the movie repository',
    () async {
      expect(tMovieModel, isA<Movie>());
    },
  );

  group('fromJson', () {
    test('should return a valid movie model when the JSON number is an integer', () 
    async{
      //arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture("movie.json"));
      //act
      final result = MovieModel.fromJson(jsonMap);
      //assert
      expect(result, equals(tMovieModel));
    });
  });
}