import 'package:flutter/material.dart';

class StatefulWidgetWrapper extends StatefulWidget {
  final Function onInit;
  final Widget child;

  const StatefulWidgetWrapper(
      {Key key, @required this.onInit, @required this.child})
      : super(key: key);
  @override
  _StatefulWidgetWrapperState createState() => _StatefulWidgetWrapperState();
}

class _StatefulWidgetWrapperState extends State<StatefulWidgetWrapper> {
  @override
  void initState() {
    if (widget.onInit != null) {
      widget.onInit();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
