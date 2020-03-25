part of 'users_ratings_bloc.dart';

abstract class UsersRatingsState extends Equatable {
  const UsersRatingsState();
}

class Initial extends UsersRatingsState {
  @override
  List<Object> get props => [];
}

class Loading extends UsersRatingsState {
  @override
  List<Object> get props => [];
}

class Loaded extends UsersRatingsState {
  final List<Rating> ratings;

  Loaded({@required this.ratings});
  @override
  List<Object> get props => [this.ratings];
}

class Error extends UsersRatingsState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [this.message];
}
