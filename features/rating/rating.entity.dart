import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class Rating extends Equatable
{

  final num rating;
  final int movieId;
  final int userId;
  final bool selectedByAI;

  Rating({@required this.rating, @required this.movieId, @required this.userId, @required this.selectedByAI});


  @override
  List<Object> get props => [movieId, userId];
  
}