import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: buildScreen(context),
    );
  }

  Widget buildScreen(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width * 0.8,
      // margin: EdgeInsets.only(right: 40, left: 40),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.70,
              child: TextField(
                decoration: InputDecoration(hintText: "Email"),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.70,
              child: Column(
                children: <Widget>[
                  Text("Email"),
                  TextField(
                    scrollPadding: EdgeInsets.symmetric(horizontal: 40.0),
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "Password"),
                  ),
                ],
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    FlatButton(
                        color: Colors.blueAccent,
                        onPressed: () {},
                        child: Text("Login")),
                    FlatButton(
                      color: Colors.redAccent,
                      onPressed: () {},
                      child: Text("Sign Up"),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  // Widget buildButtons(BuildContext context) {
  //   return Container(
  //     width: MediaQuery.of(context).size.width * 0.70,
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //       children: <Widget>[
  //         FlatButton(
  //             // color: Colors.blueAccent,
  //             onPressed: () {},
  //             child: Text("Login")),
  //         FlatButton(
  //           // color: Colors.redAccent,
  //           onPressed: () {},
  //           child: Text("Sign Up"),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
