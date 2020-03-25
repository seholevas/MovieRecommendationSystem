import 'package:flutter/material.dart';
import 'package:recommend/production/features/movie/presentation/widgets/shelf.widget.dart';
import 'package:recommend/production/features/rating/domain/entities/rating.entity.dart';

class Shelves extends StatelessWidget {
  final List<Rating> ratings;

  Shelves({@required this.ratings});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: ratings.length,
          itemBuilder: (context, index) {
            return Shelf(movieId: ratings[index].movieId);
          }),
    );
  }
}
