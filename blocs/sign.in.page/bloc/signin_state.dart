part of 'signin_bloc.dart';

abstract class SignInState extends Equatable {
  const SignInState();
}

class InitialState extends SignInState {
  @override
  List<Object> get props => [];
}

class LoadingState extends SignInState {
  @override
  List<Object> get props => [];
}

class LoadedState extends SignInState {
  final User user;

  LoadedState({@required this.user});

  @override
  List<Object> get props => [this.user];
}

class ErrorState extends SignInState {
  final String message;
  ErrorState({@required this.message});

  @override
  List<Object> get props => [this.message];
}