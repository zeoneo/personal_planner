import 'package:flutter/material.dart';

typedef void ScheduleClicked();

class ScheduleView extends StatelessWidget {
  ScheduleView({Key key}) : super(key: key);

  onClicked() {
    print("Clicked");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClicked,
      child: Card(
        semanticContainer: true,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Schedule1"),
            Text("Schedule1"),
            Text("Schedule1"),
            Text("Schedule1"),
            Text("Schedule1"),
            Text("Schedule1"),
            Text("Schedule1"),
            Text("Schedule1"),
          ],
        ),
      ),
    );
  }
}
