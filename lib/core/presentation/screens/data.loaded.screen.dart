import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:recommend/core/presentation/pages/browse.page.dart';
import 'package:recommend/production/features/movie/domain/entities/movie.entity.dart';
import 'package:recommend/production/features/rating/domain/entities/rating.entity.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class DataLoadedScreen extends StatelessWidget {
  final List<Rating> ratings;
  final List<Movie> movies;

  DataLoadedScreen({@required this.ratings, @required this.movies});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(context),
        body: _buildBody(context));
  }


  Widget _appBar(BuildContext context)
  {
    return AppBar(
      title: Text("FlixNet"),
      automaticallyImplyLeading: false,
      actions: <Widget>[Container(alignment: Alignment.centerRight,
      child: GestureDetector(onTap: (){ Navigator.pop(context, MaterialPageRoute(builder: (context)=> BrowsePage()));}, child: Row(children: <Widget>[Icon(Icons.home, size: 40,), Text("Back To Browse Page")],),),),],
    );
  }

  Widget _buildBody(BuildContext context) {
    return _buildCharts(
        context); //_buildScatterPlot(); //_buildSimpleBarChart();//_buildPopularityPieChart();
  }

  Widget _buildPopularityPieChart(BuildContext context) {
    return _buildSimplePieChart(context);
  }

  Widget _buildSimpleBarChart(BuildContext context) {
    return charts.BarChart(
      _createBarChartTemplate(),
      animate: true,
    );
  }

  Widget _explanationCard(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * .2,
        height: MediaQuery.of(context).size.height * .2,
        child: Card(
          child: Column(children: <Widget>[
            Text("Welcome to your dashboard!"),
            Text(
                "If you want to look at some neat data, please scroll below. The data itself is layed out very minimally and colorfully.")
          ]),
        ));
  }

  Widget _buildCharts(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        _explanationCard(context),
        _buildAccuracyStatistic(context),
        _buildScatterPlot(context),
        _buildPopularityPieChart(context),
        _buildHorizontalBarChart(context)
      ],
    );
  }

  Widget _buildScatterPlot(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.width * 1,
        child: Card(
            child: Column(children: <Widget>[
          Text("ENJOYABLE MOVIE INTERACTIVITY"),
          Expanded(
              child: charts.ScatterPlotChart(
            _createScatterPlotTemplate(),
            animate: true,
          )),
          Text(
              "THIS SCATTER PLOT DISPLAYS ALL THE MOVIES YOU WATCHED AND PLACES THEM ON A GRAPH BASED ON HOW MANY OTHER PEOPLE HAD POSITVE REACTIONS WITH THE MOVIE.")
        ])));
  }

  Widget _buildAccuracyStatistic(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .5,
      width:  MediaQuery.of(context).size.width,
      child: Card(child: Column(children: <Widget>[
        Text("ARTIFICIAL INTELLIGENCE ACCURACY"),
        _calculateAccuracy(),
        Text("This calculates the accuracy of the model, by taking all the movies you engaged with that the artificial intelligence selected, and divides them by the total amount of movies you engaged with and then deisplays them as a percent.This calculate")
        
        ])),
    );
  }

  List<charts.Series<Movie, String>> _createBarChartTemplate() {
    final data = movies;

    return [
      new charts.Series<Movie, String>(
          id: 'Movies',
          colorFn: (Movie movie, __) {
            final bucket = movie.vote_average;
            if (bucket < 3) {
              return charts.MaterialPalette.blue.shadeDefault;
            }
            if (bucket > 5 && bucket < 7) {
              return charts.MaterialPalette.red.shadeDefault;
            } else {
              return charts.MaterialPalette.green.shadeDefault;
            }
          },
          domainFn: (Movie movie, _) {
            return movie.genres[0].name;
          },
          measureFn: (Movie movie, _) {
            return movie.vote_average;
          },
          data: data,
          labelAccessorFn: (Movie movie, _) => '${movie.title}')
    ];
  }

  List<charts.Series<Movie, int>> _createScatterPlotTemplate() {
    final data = movies;

    return [
      new charts.Series<Movie, int>(
          id: 'Movies',
          colorFn: (Movie movie, __) {
            final bucket = movie.vote_average;
            if (bucket < 3) {
              return charts.MaterialPalette.blue.shadeDefault;
            }
            if (bucket > 5 && bucket < 7) {
              return charts.MaterialPalette.red.shadeDefault;
            } else {
              return charts.MaterialPalette.green.shadeDefault;
            }
          },
          domainFn: (Movie movie, _) => movie.id,
          measureFn: (Movie movie, _) => movie.vote_count,
          radiusPxFn: (Movie movie, _) {
            return 11;
          },
          data: data,
          labelAccessorFn: (Movie movie, _) => '${movie.title}')
    ];
  }

  Widget _buildHorizontalBarChart(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.width * 1,
      child: Card(
          child: Column(children: <Widget>[
        Text("GENRE PROBABILITY"),
        Expanded(
            child: charts.BarChart(_createChartTemplate(),
                animate: true, vertical: false)),
        Text(
            "This graph shows the rating of your movies based on their main genre, the AI then attempts to figure out what genre(s) you would be most likely to watch based upon your interactions with the rating system. \nGreen: <70%\nBlue: >40%>70%\nRed: >40%")
      ])),
    );
  }

  Widget _buildSimplePieChart(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.width * 1,
        child: Card(
          child: Column(children: <Widget>[
            Text("RE-WATCHABILITY"),
            Expanded(
              child: charts.PieChart(
                _createPieChartTemplate(),
                animate: true,
                defaultRenderer: charts.ArcRendererConfig(
                    arcRendererDecorators: [
                      charts.ArcLabelDecorator(
                          labelPosition: charts.ArcLabelPosition.inside)
                    ]),
// behaviors: [charts.DatumLegend(horizontalFirst: false, cellPadding: EdgeInsets.all(4.0), showMeasures: true, measureFormatter: (num value){return '${value/8000}%';})],
              ),
            ),
            Text(
                "This chart displays in pie-chart format the probability of you rewatching a specific movie based on what you and others have thought about it."),
          ]),
        ));
  }

  List<charts.Series<Movie, String>> _createPieChartTemplate() {
    final data = movies;

    return [
      new charts.Series<Movie, String>(
          id: 'Movies',
          colorFn: (Movie movie, __) {
            return charts.MaterialPalette.blue.shadeDefault;
          },
          domainFn: (Movie movie, _) => movie.vote_count.toString(),
          measureFn: (Movie movie, _) => movie.vote_average * movie.vote_count,
          data: data,
          labelAccessorFn: (Movie movie, _) => '${movie.title}')
    ];
  }

  List<charts.Series<Movie, String>> _createChartTemplate() {
    final data = movies;

    return [
      new charts.Series<Movie, String>(
          id: 'Movies',
          colorFn: (Movie movie, __) {
            final maxMeasure = 6;
            final r = Random();
            final bucket = r.nextInt(6); //movie.vote_count % maxMeasure;
            if (bucket == 1 || bucket == 2 || bucket == 3 || bucket == 4) {
              return charts.MaterialPalette.blue.shadeDefault;
            }
            if (bucket == 5) {
              return charts.MaterialPalette.red.shadeDefault;
            } else {
              return charts.MaterialPalette.green.shadeDefault;
            }
          },
          domainFn: (Movie movie, _) => movie.genres[0].name,
          measureFn: (Movie movie, _s) => movie.vote_average / 2,
          data: data,
          labelAccessorFn: (Movie movie, _) => '${movie.title}')
    ];
  }

  Widget _calculateAccuracy() {
    int trueFlag = 0;
    int allFlag = 0;

    for (int i = 0; i< ratings.length; i++) {
      if (ratings[i].selectedByAI.toString() == 'true') {
        trueFlag++;
      }
      allFlag++;
    }

    var value = (trueFlag/allFlag) * 100;
      return Text(
        "${value.round()}%", style: TextStyle(height: 5, fontSize: 30),);
  }
}
