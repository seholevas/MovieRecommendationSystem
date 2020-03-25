part of 'rating_bloc.dart';

abstract class RatingState extends Equatable {
  const RatingState();
}

class Initial extends RatingState {
  @override
  List<Object> get props => [];
}

class Loading extends RatingState {
  @override
  // TODO: implement psrops
  List<Object> get props => [];
}

class Loaded extends RatingState {
  final Rating rating;

  Loaded({@required this.rating});
  // TODO: implement props
  @override
  List<Object> get props => [];
}

class Error extends RatingState {
  final String message;

  Error({@required this.message});
  List<Object> get props => [this.message];
}
