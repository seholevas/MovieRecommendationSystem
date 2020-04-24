import 'package:flutter/foundation.dart';
import 'package:recommend/features/ai/ai.entity.dart';

class KNNModel extends KNN {
  KNNModel({@required suggestions}) : super(suggestions: suggestions);

  Map<String, dynamic> toJson() {
    return {'recommendations': suggestions};
  }

  factory KNNModel.fromJson(Map<String, dynamic> json) {
    List<num> suggestionsList = new List<num>.from(json['recommendations']);
    final model = KNNModel(
      suggestions: suggestionsList,
    );

    return model;
  }
}
