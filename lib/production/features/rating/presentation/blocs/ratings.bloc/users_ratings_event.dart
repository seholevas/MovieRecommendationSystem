part of 'users_ratings_bloc.dart';

abstract class UsersRatingsEvent extends Equatable {
  const UsersRatingsEvent();
}

class GetUsersRatingsEvent extends UsersRatingsEvent{
  @override
  List<Object> get props => [];
}