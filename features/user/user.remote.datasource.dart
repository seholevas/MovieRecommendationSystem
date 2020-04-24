import 'dart:convert';
// import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:recommend/core/errors/server.exception.dart';
import 'package:recommend/core/errors/client.exception.dart';
import 'package:recommend/features/user/user.model.dart';


abstract class UserRemoteDataSource {
  /// Calls the https://googlapi.herokuapp.com/database/read_user/{uuid} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<UserModel> getUserInformation();
  Future<UserModel> signIn(Map<String, dynamic> dictionary);
  Future<UserModel> createAccount(Map<String, dynamic> dictionary);

}

class UserRemoteDataSourceImplementation implements UserRemoteDataSource {
  final http.Client client;
  //  Map<String, String> requestHeaders = {
      //  'Content-type': 'application/json',
      //  'Accept': 'application/json',
      //  'Authorization': '<Your token>'
    //  };

  UserRemoteDataSourceImplementation({
    @required this.client});

  @override
  Future<UserModel> getUserInformation() =>
      _getUserFromUrl('https://googlapi.herokuapp.com/firebase/database/user');


   @override
  Future<UserModel> createAccount(Map<String, dynamic> dictionary) => _postUserFromUrl("https://googlapi.herokuapp.com/firebase/auth/create_user", dictionary);

  Future<UserModel> signIn(Map<String, dynamic> dictionary) => _postUserFromUrl("https://googlapi.herokuapp.com/firebase/auth/sign_in", dictionary);
 
  Future<UserModel> _getUserFromUrl(String url) async {
    final response = await client.get(
      url,
      // headers: requestHeaders
      // {
        // HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
      // },
    );

    return _checkResponse(response);
  }

   Future<UserModel> _postUserFromUrl(String url, Map<String, dynamic> dictionary) async {
    final response = await http.post(
      url,
      // headers: requestHeaders,
      body: dictionary
        // requestHeaders
        // HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
    );

    return _checkResponse(response);
  }

   UserModel _checkResponse(http.Response response)
  {
    if(response.statusCode == 200)
    {
      return UserModel.fromJson(json.decode(response.body));
    }
    else if(response.statusCode >= 500)
    {
      throw ServerException();
    }
    else
    {
      throw ClientException();
    }
  } 
}