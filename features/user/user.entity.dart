import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class User extends Equatable {
  final String userUID;
  final String username;
  final int numUserId;
  final String email;
  final String password; //DONT NEED

  User(
      {@required this.userUID,
      @required this.numUserId,
      @required this.username,
      @required this.email,
      @required this.password});

  // @override
  List<Object> get props => [];
}
