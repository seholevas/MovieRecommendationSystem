import 'package:flutter/material.dart';
import 'package:recommend/core/presentation/widgets/rating.form.widgit.dart';
import 'package:recommend/production/features/movie/domain/entities/movie.entity.dart';
import 'package:recommend/production/features/movie/presentation/widgets/shelf.widget.dart';

class HeroPage extends StatelessWidget {
  final Movie movie;

  const HeroPage({Key key, @required this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:  _body(context)  
    );
  }

Widget _body(BuildContext context)
{
  return Container(
      child: ListView(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: <Widget>[_heroImage(context),
      _ratingForm(),
        _movieTitle(context),
      _movieTagline(context),
      _movieOverview(context),
      _similarMovies(context),

      ],
    ),
  );
}
 Widget _ratingForm()
 {
   return RatingForm(movie: this.movie);
 }


Widget _heroImage(BuildContext context){
  return  Container(
    // height: MediaQuery.of(context).size.height *.3,

    child:Image.network(
                    "https://image.tmdb.org/t/p/w500/${movie.posterPath}",
                    fit: BoxFit.fill,));
}

Widget _movieTitle(BuildContext context, ){
  return Container(
    // height: MediaQuery.of(context).size.height *.2,
    child: Text("${movie.title}"),
  );
}

Widget _movieTagline(BuildContext context)
{
  return Container(
    // height: MediaQuery.of(context).size.height *.2,
    child: (Text("${movie.tagline}")),
  );
}

Widget _movieOverview(BuildContext context)
{
  return Container(
    // height: MediaQuery.of(context).size.height *.2,
    child: (Text("${movie.overview}")),
  );
}

Widget _similarMovies(BuildContext context)
{
  return Column(
  children: <Widget>[Container(
    alignment: Alignment.topLeft,
    child:Text("Similar To ${movie.title}: ")),Shelf(movieId: movie.id)]);
}
}