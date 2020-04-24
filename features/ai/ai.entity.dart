import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class KNN extends Equatable
{
  final List<int> suggestions;

  KNN({@required this.suggestions});

  @override
  List<Object> get props => [suggestions];

}