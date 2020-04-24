import 'package:flutter/foundation.dart';
import 'package:recommend/features/user/user.entity.dart';

class UserModel extends User
{
  UserModel( {
    @required userUID,
    @required username,
    @required email,
    @required password,
    @required numUserId,
    }) : super(userUID: userUID, numUserId: numUserId, username: username, email: email, password: password);


  factory UserModel.fromJson(Map json)
  {
    return UserModel(
      userUID: json['user_id'],
      username: json['username'],
      numUserId: int.parse(json['num_user_id']),
      email: json['email'],
      password: json['password'], 

    );
  }

  Map<String, dynamic> toJson()
  {
    return {
      "user_id": userUID.toString(),
      "username": username.toString(),
      "num_user_id": numUserId.toString(),
      "email": email.toString(),
      "password": password,
    };
  }


}