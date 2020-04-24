part of 'signin_bloc.dart';

abstract class SignInEvent extends Equatable {
  // const SigninEvent();
}

class SignInButtonPressedEvent extends SignInEvent
{
  final String email;
  final String password;

  SignInButtonPressedEvent({@required this.email, @required this.password});
  @override
  List<Object> get props => [this.email, this.password];
}
