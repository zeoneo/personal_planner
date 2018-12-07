import 'package:flutter/material.dart';

class MonthlyPlanner extends StatefulWidget {
  MonthlyPlanner({Key key}) : super(key: key);

  @override
  MonthlyPlannerState createState() {
    return new MonthlyPlannerState();
  }
}

class MonthlyPlannerState extends State<MonthlyPlanner> {
  @override
  Widget build(BuildContext context) {
    return new Center(
        child: new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Text(
          "Monthly Planner",
          style: new TextStyle(fontSize: 48.0, fontWeight: FontWeight.w300),
        ),
      ],
    ));
  }
}
