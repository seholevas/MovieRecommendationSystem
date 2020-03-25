import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:recommend/core/abstractions/entities/entity.interface.dart';

class Rating extends Equatable implements Entity
{
  final int userId;
  final int movieId;
  final double rating;
  final bool selectedByAI;

  Rating({
    @required this.userId,
    @required this.movieId,
    @required this.rating,
    @required this.selectedByAI
  });

  @override
  List<Object> get props => [];

}
