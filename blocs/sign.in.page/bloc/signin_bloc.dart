import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:recommend/features/user/user.entity.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SignInEvent, SignInState> {
  @override
  SignInState get initialState => InitialState();

  @override
  Stream<SignInState> mapEventToState(
    SignInEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
