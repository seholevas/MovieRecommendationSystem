import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:recommend/features/ai/ai.model.dart';
import "package:http/http.dart" as http;
import 'package:recommend/core/errors/server.exception.dart';

abstract class KNNRemoteDataSource {
  /// Calls the diamond-betty.herokuapp.com/ endpoint
  ///
  /// Throws a [ServerException] for all error codes.
  Future<KNNModel> getSuggestions(int movieId, int nSuggestions);

  /// Calls the diamond-betty.herokuapp.com/ endpoint
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<KNNModel>> getSuggestionsForManyMovies(
      List<int> movieIds, int nSuggestions);
}

class KNNRemoteDataSourceImplementation implements KNNRemoteDataSource {
  final http.Client client;

  KNNRemoteDataSourceImplementation({@required this.client});
  @override
  Future<KNNModel> getSuggestions(int movieId, int nSuggestions) async =>
      await _getAIInformationFromUrl(
          "https://diamond-betty.herokuapp.com/$movieId/$nSuggestions");

  Future<KNNModel> _getAIInformationFromUrl(String url) async {
    // final Map<String, String>
    final response = await client.get(url);

    if (response.statusCode == 200) {
      return KNNModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  Future<List<KNNModel>> _getMultipleAISuggestionsFromUrl(
      String url, List<int> movieIds, int nSuggestions) async {
    List<KNNModel> aiList = [];
    for (int i = 0; i < movieIds.length; i++) {
      int index = movieIds[i];
      var tempUrl = url + "/$index/$nSuggestions";
      aiList.add(await _getAIInformationFromUrl(tempUrl));
    }
    return aiList;
  }

  @override
  Future<List<KNNModel>> getSuggestionsForManyMovies(
          List<int> movieIds, int nSuggestions) =>
      _getMultipleAISuggestionsFromUrl(
          "https://diamond-betty.herokuapp.com/", movieIds, nSuggestions);
}
