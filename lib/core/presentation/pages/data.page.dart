import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommend/core/presentation/screens/data.loaded.screen.dart';
import 'package:recommend/core/presentation/screens/loading.screen.dart';
import 'package:recommend/injection.container.dart';
import 'package:recommend/production/features/movie/presentation/movies_bloc/bloc/movies_bloc.dart';
import 'package:recommend/production/features/rating/domain/entities/rating.entity.dart';

class DataPage extends StatelessWidget 
{
  final List<Rating> ratings;

  const DataPage({Key key, @required this.ratings}) : super(key: key);
   @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  BlocProvider<MoviesBloc> _buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MoviesBloc>(),
      child: BlocBuilder<MoviesBloc, MoviesState>(
          builder: (context, state) => _stateChanger(context, state)),
    );
  }

  Widget _stateChanger(BuildContext context, MoviesState state) {
    if (state is Initial) {
      BlocProvider.of<MoviesBloc>(context).add(GetMoviesEvent(ratings: this.ratings));
      return Container(child: Text("BLANK"),);
    }
    if (state is Loading) {
      return LoadingScreen();
    }
    if (state is Error) {
      return Container(width: 5, height: 5,child: Text("ERROR!"));
      // return ErrorScreen();
    }

    if (state is Loaded) {
      return DataLoadedScreen(ratings: this.ratings, movies: state.movies,);
    }
  }
}
// {
//   final List<Rating> ratings;

//   DataPage({Key key, @required this.ratings}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Your Dashboard"),),
//       body: _buildSimplePieChart(),);
//   }


//   Widget _buildSimpleBarChart(){
//     return charts.BarChart(_createBarChartTemplate(), animate: true,);
//   }

//    List<charts.Series<Rating,String>> _createBarChartTemplate()
//   {
//     final data = ratings;
    
//     return [new charts.Series<Rating, String>(
//       id: 'Ratings',
//       colorFn: (_,__) => charts.MaterialPalette.blue.shadeDefault,
//       domainFn: (Rating rating, _) => (rating.movieId).toString(),
//       measureFn: (Rating rating, _) => (rating.rating/2),
//       data: data
//     )];
//   }

//   Widget _buildSimplePieChart()
//   {
//     return charts.PieChart(_createPieChartTemplate(), animate: true);
//   }

//  List<charts.Series<Rating, String>> _createPieChartTemplate()
//  {
//    final data = ratings;

//    return [new charts.Series<Rating, String>(
//      id: 'Ratings',
//      colorFn: (_,__) => charts.MaterialPalette.blue.shadeDefault,
//      domainFn: (Rating rating, _) => (rating.movieId).toString(),
//      measureFn: (Rating rating, _) =>(rating.rating/2),
//      data: data
//    )];
//  } 
// }
