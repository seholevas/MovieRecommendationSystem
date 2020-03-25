import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:recommend/core/errors/server.exception.dart';
import 'package:recommend/core/errors/client.exception.dart';
import 'package:recommend/production/features/rating/data/models/rating.model.dart';

abstract class RatingRemoteDataSource {
  /// Calls the https://googlapi.herokuapp.com/database/rating/ endpoint.
  ///
  /// Throws a [ServerException] or [Client Exception] for all error codes.
  Future<RatingModel> getRatingInformation(int movieId);

  Future<RatingModel> postRatingInformation(
      Map<String, dynamic> dictionaryValues);
  
  Future<List<RatingModel>> getEveryRatingByUser();
}

class RatingRemoteDataSourceImplementation implements RatingRemoteDataSource {
  final http.Client client;

  RatingRemoteDataSourceImplementation({@required this.client});

  @override
  Future<RatingModel> postRatingInformation(
          Map<String, dynamic> dictionaryValues) =>
      _postRatingToUrl(
          // "http://127.0.0.1:5000/firebase/database/rating",
          "https://googlapi.herokuapp.com/firebase/database/rating",
          dictionaryValues);
  @override
  Future<RatingModel> getRatingInformation(int movieId) => _getRatingFromUrl(
      'https://googlapi.herokuapp.com/firebase/database/rating?movie_id=$movieId');

        @override
  Future<List<RatingModel>> getEveryRatingByUser() => _getRatingsFromUrl('https://googlapi.herokuapp.com/firebase/database/ratings');

  Future<List<RatingModel>> _getRatingsFromUrl(String url)
  async {
    final response = await client.get(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
      },
    );

    return _checkResponseWithList(response);
  }

  Future<RatingModel> _postRatingToUrl(
      String url, Map<String, dynamic> dictionaryValues) async {
    final response = await http.post(Uri.parse(url), body: dictionaryValues);
    return _checkResponse(response);
  }

  Future<RatingModel> _getRatingFromUrl(String url) async {
    final response = await client.get(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
      },
    );

    return _checkResponse(response);
  }

  RatingModel _checkResponse(http.Response response) {
    if (response.statusCode == 200) {
      if(response.body =="null" || response.body == "null\n")
      {
        throw ServerException();
      }
      return RatingModel.fromJson(json.decode(response.body));
    } else if (response.statusCode >= 500) {
      throw ServerException();
    } else {
      throw ClientException();
    }
  }

  List<RatingModel> _checkResponseWithList(http.Response response)
  {

        if (response.statusCode == 200) {
        final decodedJson = json.decode(response.body);
        if(decodedJson == "null")
        {
          List<RatingModel> emptyList = [];
          return emptyList;
        }
       
        else{
        final responseBody = response.body;
        var ratings = (json.decode(responseBody) as List).map((e) => new RatingModel.fromJson(e)).toList();
        return ratings;
        }
    } else if (response.statusCode >= 500) {
      throw ServerException();
    } else {
      throw ClientException();
    }

  }
  }

