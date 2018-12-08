import 'package:flutter/material.dart';
import 'package:daily_planner/model/ScheduleItem.dart';
import 'schedule_row.dart';

typedef void ScheduleClicked();

class ScheduleCard extends StatelessWidget {
  ScheduleCard(
      {Key key, @required this.onScheduleClick, @required this.scheduleItems})
      : super(key: key);

  final List<ScheduleItem> scheduleItems;
  final ScheduleClicked onScheduleClick;

  @override
  Widget build(BuildContext context) {
    List<Widget> scheduleItemWidgets = scheduleItems
        .map(
          (item) => new ScheduleRow(
                item: item,
              ),
        )
        .toList();
    return GestureDetector(
      onTap: onScheduleClick,
      child: Card(
        semanticContainer: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                new Expanded(
                  child: Text(
                    "Time",
                    style: TextStyle(
                        color: Color.fromRGBO(100, 200, 150, 1.9),
                        fontWeight: FontWeight.bold),
                  ),
                  flex: 3,
                ),
                new Expanded(
                  child: Text(
                    "Task Name",
                    style: TextStyle(
                        color: Color.fromRGBO(100, 200, 150, 1),
                        fontWeight: FontWeight.bold),
                  ),
                  flex: 7,
                ),
              ],
            ),
            new Expanded(
              child: new ListView.builder(
                itemCount: scheduleItemWidgets.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return scheduleItemWidgets[index];
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
