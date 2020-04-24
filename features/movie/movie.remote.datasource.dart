import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:recommend/core/errors/server.exception.dart';
import 'package:recommend/core/errors/client.exception.dart';
import 'package:recommend/features/movie/movie.model.dart';
import "package:http/http.dart" as http;

abstract class MovieRemoteDataSource {
  /// Calls the http://tmdb.api/movies endpoint
  ///
  /// Throws a [ServerException] for all error codes.
  Future<MovieModel> getMovieInformation(int id);

  Future<List<MovieModel>> getListOfMoviesInformation(List<int> movieIds);
}

class MovieRemoteDataSourceImplementation implements MovieRemoteDataSource {
  final http.Client client;

  MovieRemoteDataSourceImplementation({@required this.client});
  @override
  Future<MovieModel> getMovieInformation(int id) => _getMovieInformationFromUrl(
      "https://api.themoviedb.org/3/movie/$id?&api_key=cfe422613b250f702980a3bbf9e90716");

  Future<MovieModel> _getMovieInformationFromUrl(String url) async {
    final response = await client.get(
      url,
    );

    return _checkResponse(response);
  }

  MovieModel _checkResponse(http.Response response) {
    if (response.statusCode == 200) {
      return MovieModel.fromJson(json.decode(response.body));
    } else if (response.statusCode >= 500) {
      throw ServerException();
    } else {
      throw ClientException();
    }
  }

  Future<List<MovieModel>> _getMovieListInformationFromUrl(
      List<int> movieIds) async {
    List<MovieModel> moviesList = [];
    for (int i = 0; i < movieIds.length; i++) {
      moviesList.add(await getMovieInformation(movieIds[i]));
    }
    return moviesList;
  }

  @override
  Future<List<MovieModel>> getListOfMoviesInformation(List<int> movieIds) =>
      _getMovieListInformationFromUrl(movieIds);
}
