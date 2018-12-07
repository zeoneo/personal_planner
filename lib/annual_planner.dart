import 'package:flutter/material.dart';

class AnnualPlanner extends StatefulWidget {
  AnnualPlanner({Key key}) : super(key: key);

  @override
  AnnualPlannerState createState() {
    return new AnnualPlannerState();
  }
}

class AnnualPlannerState extends State<AnnualPlanner> {
  @override
  Widget build(BuildContext context) {
    return new Center(
        child: new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Text(
          "Annual Planner",
          style: new TextStyle(fontSize: 48.0, fontWeight: FontWeight.w300),
        ),
      ],
    ));
  }
}
