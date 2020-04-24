import 'package:flutter/foundation.dart';
import 'package:recommend/features/movie/genre.entity.dart';
import 'package:recommend/features/movie/genre.model.dart';
import 'package:recommend/features/movie/movie.entity.dart';

class MovieModel extends Movie
{
  MovieModel( {
    @required id,
    @required title,
    @required tagline,
    @required overview,
    @required voteCount,
    @required voteAverage,
    @required genres,
    @required backdropPath,
    @required posterPath}) : super(tmdbId: id, title: title, tagline: tagline, overview: overview, voteCount: voteCount, voteAverage: voteAverage, genres: genres, backdropPath: backdropPath, posterPath: posterPath);


  factory MovieModel.fromJson(Map<String, dynamic> json)
  {
    final jsonGenres = json['genres'];
    final List<Genre> genres = [];

    for(Map<String, dynamic> genre in jsonGenres)
    {
      genres.add(GenreModel.fromJson(genre));
    }

    var movieModel = MovieModel(
      id: json["id"],
      title: json["title"],
      tagline: json["tagline"] ,
      overview: json["overview"],
      voteCount: json["vote_count"],
      voteAverage: json["vote_average"],
      posterPath: json['poster_path'],
      backdropPath: json["backdrop_path"],
      genres : genres);

      return movieModel;
}
}