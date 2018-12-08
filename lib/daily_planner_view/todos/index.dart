import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'schedule_card.dart';
import 'schedule_expanded.dart';
import '../../model/ScheduleItem.dart';

class TodosComponent extends StatefulWidget {
  TodosComponent({Key key}) : super(key: key);

  @override
  TodosComponentState createState() {
    return new TodosComponentState();
  }
}

class TodosComponentState extends State<TodosComponent> {
  //Prop
  List<ScheduleItem> scheduleItems = [];

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  _changeData(List<ScheduleItem> _items) {
    setState(() {
      scheduleItems = _items;
    });
  }

  _refreshData() {
    DateTime now = DateTime.now();
    DateTime today = new DateTime(now.year, now.month, now.day);

    Firestore.instance
        .collection('todos')
        .where("from", isGreaterThanOrEqualTo: today)
        .snapshots()
        .listen((data) {
      List<ScheduleItem> _items = [];
      data.documents.forEach((doc) => _items.add(ScheduleItem(
          itemDetail: doc.data["title"],
          startTime: (doc.data["from"]),
          endTime: (doc.data["to"]))));
      print(_items.toString());
      _changeData(_items);
    });
  }

  @override
  Widget build(BuildContext context) {
    return scheduleItems.length == 0
        ? Card(
            semanticContainer: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Text("Todos"),
                FloatingActionButton(
                  tooltip: "Add today's Todos",
                  child: Icon(Icons.add),
                  backgroundColor: Color.fromRGBO(10, 150, 20, 1),
                  elevation: 1,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ExpandedSchedule(
                              scheduleItems: scheduleItems,
                              refreshCallback: _refreshData)),
                    );
                  },
                )
              ],
            ),
          )
        : new ScheduleCard(
            onScheduleClick: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ExpandedSchedule(
                          scheduleItems: scheduleItems,
                        )),
              );
            },
            scheduleItems: scheduleItems);
  }
}
