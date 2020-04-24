import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class Genre extends Equatable {
  final int genreId;
  final String genreName;

  Genre({@required this.genreId, @required this.genreName});

  @override
  List<Object> get props => [genreId, genreName];
}
