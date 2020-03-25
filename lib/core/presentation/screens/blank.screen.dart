import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommend/core/presentation/widgets/stateful.widget.wrapper.dart';
import 'package:recommend/production/features/rating/presentation/blocs/ratings.bloc/users_ratings_bloc.dart';

// class BlankScreen extends StatefulWidget{
//   // @override
//   // Widget build(BuildContext context) {
//   //   return Container(child: Text("HI"));
//   //   // Container(child: FlatButton(
//   //     // onPressed: () => _dispatchAttempt(context),
//   //     // child: Text("BLANK SCREEN!")),

//   // }

//   void _dispatchAttempt(BuildContext context)
//   {
//     BlocProvider.of<UsersRatingsBloc>(context)
//         .add(GetUsersRatingsEvent());
//   }

//   @override
//   State<StatefulWidget> createState() => _MyState();
// }

// class _MyState extends State<StatefulWidget>{
//   @override
//   Widget build(BuildContext context) {

//     return Scaffold( body: Container(child: Text("hi")));
//   }

//   void _dispatch(BuildContext context)
//   {
//     BlocProvider.of<UsersRatingsBloc>(context)
//         .add(GetUsersRatingsEvent());
// }

class BlankScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(width: 50, height: 50, 
    // child:
      //   BlocListener<UsersRatingsBloc, UsersRatingsState>(
      //       listener: (BuildContext context, UsersRatingsState state) {
      // if (state is Initial) {
      //   print("hello");
      //   BlocProvider.of<UsersRatingsBloc>(context).add(GetUsersRatingsEvent());
      // }
    ));
    }
    // )
    // )
    // );
  }
