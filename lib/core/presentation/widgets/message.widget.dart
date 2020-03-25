import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  final text;

  const MessageWidget({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(text),
      
    );
  }
}