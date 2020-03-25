import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:recommend/core/abstractions/usecase/usecase.interface.dart';
import 'package:recommend/core/errors/client.failure.dart';
import 'package:recommend/core/errors/failure.interface.dart';
import 'package:recommend/core/errors/server.failure.dart';
import 'package:recommend/production/features/rating/data/models/rating.model.dart';
import 'package:recommend/production/features/rating/domain/entities/rating.entity.dart';
import 'package:recommend/production/features/rating/domain/usecases/get.all.rated.movies.from.user.dart';

part 'users_ratings_event.dart';
part 'users_ratings_state.dart';



const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CLIENT_FAILURE_MESSAGE = 'Client Failure';

class UsersRatingsBloc extends Bloc<UsersRatingsEvent, UsersRatingsState> {
  final GetAllMoviesUserRated getAllMoviesUserRated;
  // final StreamController<List<Rating>> _controller = StreamController<List<Rating>>();

  UsersRatingsBloc({@required this.getAllMoviesUserRated})
      : assert(getAllMoviesUserRated != null);

  @override
  UsersRatingsState get initialState => Initial();

  @override
  Stream<UsersRatingsState> mapEventToState(
    UsersRatingsEvent event,
  ) async* {
    if (event is GetUsersRatingsEvent) {
      yield Loading();
      final failureOrRatingList = await getAllMoviesUserRated(NoParams());
      yield* _eitherLoadedOrErrorState(failureOrRatingList);
    }
  }

  Stream<UsersRatingsState> _eitherLoadedOrErrorState(
    Either<Failure, List<Rating>> failureOrTrivia,
  ) async* {
    yield failureOrTrivia.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (ratings) => 
     
      _whenLoadedGetGoodRatingsOnly(ratings),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case ClientFailure:
        return CLIENT_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
  UsersRatingsState _whenLoadedGetGoodRatingsOnly(List<RatingModel> ratings)
  {

    return Loaded(ratings:  ratings);
  }
}
