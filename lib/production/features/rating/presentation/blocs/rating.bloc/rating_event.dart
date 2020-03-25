part of 'rating_bloc.dart';

abstract class RatingEvent extends Equatable {
  // const RatingEvent();
}

class GetRatingEvent extends RatingEvent {
  final String movieId;

  GetRatingEvent(this.movieId);
  @override
  // TODO: implement props
  List<Object> get props => [this.movieId];
}

class SubmitRatingEvent extends RatingEvent {
  final String movieId;
  final String userId;
  final String rating;
  final String selectedByAI;

  SubmitRatingEvent(this.movieId, this.userId, this.rating, this.selectedByAI);

  @override
  // TODO: implement props
  List<Object> get props =>
      [this.movieId, this.userId, this.rating, this.selectedByAI];
}
