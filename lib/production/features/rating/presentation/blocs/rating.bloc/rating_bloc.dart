import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:recommend/core/errors/client.failure.dart';
import 'package:recommend/core/errors/failure.interface.dart';
import 'package:recommend/core/errors/server.failure.dart';
import 'package:recommend/core/util/input.converter.dart';
import 'package:recommend/production/features/rating/domain/entities/rating.entity.dart';
import 'package:recommend/production/features/rating/domain/usecases/get.rating.information.dart'
    as getRating;
import 'package:recommend/production/features/rating/domain/usecases/submit.rating.dart'
    as submitRating;

part 'rating_event.dart';
part 'rating_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CLIENT_FAILURE_MESSAGE = 'Client Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class RatingBloc extends Bloc<RatingEvent, RatingState> {
  final getRating.GetRatingInformation getRatingInformation;
  final submitRating.SubmitRatingInformation submitRatingInformation;
  final InputConverter inputConverter;

  RatingBloc(
      {@required this.getRatingInformation,
      @required this.submitRatingInformation,
      @required this.inputConverter})
      : assert(getRatingInformation != null),
        assert(submitRatingInformation != null),
        assert(inputConverter != null);

  @override
  RatingState get initialState => Initial();

  @override
  Stream<RatingState> mapEventToState(
    RatingEvent event,
  ) async* {
    if (event is GetRatingEvent) {
      final inputEither = inputConverter.stringToUnsignedInteger(event.movieId);
      yield* inputEither.fold((failure) async* {
        yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);
      }, (integer) async* {
        yield Loading();
        final failureOrRating =
            await getRatingInformation(getRating.Params(movieId: integer));
        yield* _eitherLoadedOrErrorState(failureOrRating);
      });
    } else if (event is SubmitRatingEvent) {
      {
        final input = {
          "movie_id": event.movieId,
          "rating": event.rating,
          "user_id": event.userId,
          "selected_by_ai": event.selectedByAI
        };
        yield Loading();

        final failureOrRating = await submitRatingInformation(
            submitRating.Params(dictionary: input));
        yield* _eitherLoadedOrErrorState(failureOrRating);
      }
    }
  }

  Stream<RatingState> _eitherLoadedOrErrorState(
    Either<Failure, Rating> failureOrTrivia,
  ) async* {
    yield failureOrTrivia.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (rating) => Loaded(rating: rating),
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
}
