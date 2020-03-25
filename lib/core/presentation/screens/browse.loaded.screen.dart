import 'package:flutter/material.dart';
import 'package:recommend/core/presentation/pages/data.page.dart';
import 'package:recommend/core/presentation/widgets/shelves.widget.dart';
import 'package:recommend/production/features/rating/domain/entities/rating.entity.dart';

class BrowseLoadedScreen extends StatelessWidget {
  final List<Rating> ratings;

  const BrowseLoadedScreen({Key key, @required this.ratings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _buildBody(context)
    );
  }

  Widget _buildBody(BuildContext context)
  {
    return Stack(
      children: <Widget>[Shelves(ratings: ratings)]
    );
  }

  // Widget _floatingActionButton(BuildContext context)
  // {
  //   return FloatingActionButton.extended(
  //       label: Text("Dashboard"),
  //       icon: Icon(Icons.dashboard, size: 40,),
  //       // shape: ,
  //       onPressed: _navigateToDataPage(context),
  //     );
  // }

  Widget _appBar(BuildContext context)
  {
    return AppBar(
      title: Text("FlixNet"),
      automaticallyImplyLeading: false,
      actions: <Widget>[Container(alignment: Alignment.centerRight,
      child: GestureDetector(onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> DataPage(ratings: ratings)));}, child: Row(children: <Widget>[Icon(Icons.dashboard, size: 40,), Text("Dashboard")],),),),],
    );
  }
}
