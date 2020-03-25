import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:recommend/production/features/rating/domain/entities/rating.entity.dart';
import 'package:recommend/core/abstractions/models/models.interface.dart';

class RatingModel extends Rating implements Modelable {
  RatingModel({@required userId, @required movieId, @required rating, @required selectedByAI})
      : super(userId: userId, movieId: movieId, rating: rating, selectedByAI: selectedByAI);

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    
    
    var selectedByAI;


    // NEED TO FIX
    final json_ai = json['selected_by_ai'];
    
    if( json_ai.toString().toLowerCase() == "true")
    {
      selectedByAI = true;
    }
    else
    {
      selectedByAI = false;
    }

  
    return RatingModel(
      movieId: int.parse(json['movie_id']),
      userId: int.parse(json['user_id']),
      rating: double.parse(json['rating']),
      selectedByAI: selectedByAI,
    );
  }

  //Map<String, dynamic> toJson() {
    Map<String, dynamic>toJson()
    {
    final body = {'user_id': userId.toString(), 'movie_id': movieId.toString(), 'rating': rating.toString(), 'selected_by_ai' : selectedByAI.toString()};

    return body;
  }
}
