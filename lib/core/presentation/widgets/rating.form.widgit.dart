import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommend/injection.container.dart';
import 'package:recommend/production/features/movie/domain/entities/movie.entity.dart';
import 'package:recommend/production/features/rating/presentation/blocs/rating.bloc/rating_bloc.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class RatingForm extends StatelessWidget {
  final Movie movie;

  const RatingForm({Key key, @required this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  BlocProvider<RatingBloc> _buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RatingBloc>(),
      child: BlocBuilder<RatingBloc, RatingState>(
          builder: (context, state) => _stateChanger(context, state)),
    );
  }

  Widget _stateChanger(BuildContext context, RatingState state) {
    if (state is Initial) {
      BlocProvider.of<RatingBloc>(context).add(GetRatingEvent("${movie.id}"));
      return Container(
        height: 5,
        width: 5,
      );
    }
    if (state is Loading) {
      return CircularProgressIndicator();
    }
    if (state is Error) {
      return Container(child: SmoothStarRating(allowHalfRating: false, starCount: 5, size: 40, rating: 0, spacing: 30,onRatingChanged: (rating){var ratingDoubled = rating*2;BlocProvider.of<RatingBloc>(context).add(SubmitRatingEvent("${this.movie.id}", "394938498", "$ratingDoubled", "true"));},));
      // return Container(height: 30, width: 30,child: Text("RATING FORM WIDGET ERROR!"));
      // return ErrorScreen();
    
    }

    if (state is Loaded) {
      Random r = Random();
      return Container(child: SmoothStarRating(allowHalfRating: false, starCount: 5, size: 40, spacing: 30,rating: (state.rating.rating)/2, onRatingChanged: (rating){var ratingDoubled = rating * 2; BlocProvider.of<RatingBloc>(context).add(SubmitRatingEvent("${this.movie.id}", "394938498", "$ratingDoubled", r.nextBool().toString() ));},),);
    }
  }
}