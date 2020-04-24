import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:recommend/features/ai/ai.entity.dart';
import 'package:recommend/features/ai/ai.repository.dart';
import 'package:recommend/core/errors/failure.interface.dart';
import 'package:recommend/core/usecase/usecase.interface.dart';

class GetAISuggestions implements UseCase<KNN, Params>
{
  final KNNRepository repository;

  GetAISuggestions(this.repository);

  @override
  Future<Either<Failure, KNN>> call(Params params) async 
  {
    return await repository.getSuggestions(params.id, params.nSuggestions);
  }

}

class Params extends Equatable
{
  final int id;
  final int nSuggestions;
  Params({@required this.id, @required this.nSuggestions});
  
  @override
  List<Object> get props => [id, nSuggestions];
}