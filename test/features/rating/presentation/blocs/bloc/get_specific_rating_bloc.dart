import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'get_specific_rating_event.dart';
part 'get_specific_rating_state.dart';

class GetSpecificRatingBloc extends Bloc<GetSpecificRatingEvent, GetSpecificRatingState> {
  @override
  GetSpecificRatingState get initialState => GetSpecificRatingInitial();

  @override
  Stream<GetSpecificRatingState> mapEventToState(
    GetSpecificRatingEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
