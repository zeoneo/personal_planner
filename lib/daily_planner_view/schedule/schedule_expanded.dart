import 'package:flutter/material.dart';
import 'package:flutter_list_drag_and_drop/drag_and_drop_list.dart';
import 'package:intl/intl.dart';

import 'package:daily_planner/model/ScheduleItem.dart';
import 'add_new_schedule.dart';

typedef void RefreshCallback();
typedef void DeleteCallback(String documentId);

class ExpandedSchedule extends StatelessWidget {
  ExpandedSchedule({
    Key key,
    @required this.scheduleItems,
    @required this.title,
    @required this.collection,
    @required this.refreshCallback,
    @required this.deleteCallback,
  }) : super(key: key);
  final List<ScheduleItem> scheduleItems;
  final String title;
  final String collection;
  final RefreshCallback refreshCallback;
  final DeleteCallback deleteCallback;
  @override
  Widget build(BuildContext context) {
    print("Build Called on Expanaded Schedule");

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Today's " + title),
      ),
      body: new DragAndDropList<ScheduleItem>(
        scheduleItems,
        itemBuilder: (BuildContext context, item) {
          return Dismissible(
            // Each Dismissible must contain a Key. Keys allow Flutter to
            // uniquely identify Widgets.
            key: Key(item.itemDetail),
            // We also need to provide a function that tells our app
            // what to do after an item has been swiped away.
            onDismissed: (direction) {
              // Remove the item from our data source.
              deleteCallback(item.documentKey);

              // Then show a snackbar!
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text("$item dismissed")));
            },
            // Show a red background as the item is swiped away
            background: Container(color: Colors.red),
            child: ListTile(title: Text(item.itemDetail)),
          );

          // new SizedBox(
          //   child: new Card(
          //     child: new ListTile(
          //       title: Text(item.itemDetail),
          //       subtitle: Text((new DateFormat.jm()).format(item.startTime) +
          //           " -> " +
          //           (new DateFormat.jm()).format(item.endTime)),
          //     ),
          //   ),
          // );
        },
        onDragFinish: (before, after) {
          ScheduleItem data = scheduleItems[before];
          scheduleItems.removeAt(before);
          scheduleItems.insert(after, data);
        },
        canBeDraggedTo: (one, two) => true,
        dragElevation: 10.0,
        tilt: 0.00,
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add today's item",
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewScheduleItem(
                      refreshCallback1: refreshCallback,
                      title: title,
                      collection: collection,
                    )),
          );
        },
      ),
    );
  }
}
