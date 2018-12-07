import 'package:flutter/material.dart';

typedef void ScheduleClicked();

class MotivationView extends StatelessWidget {
  MotivationView({Key key, this.onClick}) : super(key: key);

  final ScheduleClicked onClick;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Card(
        semanticContainer: true,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[new Text("Motivation")],
        ),
      ),
    );
  }
}
