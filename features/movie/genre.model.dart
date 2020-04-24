import 'package:flutter/widgets.dart';
import 'package:recommend/features/movie/genre.entity.dart';

class GenreModel extends Genre
{
  GenreModel({
    @required id,
    @required name
  }) : super(genreId: id, genreName : name);


    factory GenreModel.fromJson(Map<String, dynamic> json)
  {
    var model = GenreModel(
      id: json["id"],
      name: json["name"]);
      return model;
  }

   Map<String, dynamic> toJson() {
    return {'genres' :{
      'id': genreId,
      'name': genreName,
    }};
  }
}