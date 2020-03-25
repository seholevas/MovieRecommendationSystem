import 'package:flutter/material.dart';
import 'package:recommend/core/presentation/widgets/loading.widget.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: LoadingWidget()
    );
  }
}