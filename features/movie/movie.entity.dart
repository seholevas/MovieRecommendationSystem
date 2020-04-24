import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:recommend/features/movie/genre.entity.dart';

class Movie extends Equatable {
  final int tmdbId;
  final String title;
  final String tagline;
  final String overview;
  final String backdropPath;
  final String posterPath;
  final num voteAverage;
  final int voteCount;
  final List<Genre> genres;

  Movie(
      {@required this.tmdbId,
      @required this.title,
      @required this.tagline,
      @required this.overview,
      @required this.backdropPath,
      @required this.voteAverage,
      @required this.voteCount,
      @required this.genres,
      @required this.posterPath});

  @override
  List<Object> get props => [tmdbId];
}
