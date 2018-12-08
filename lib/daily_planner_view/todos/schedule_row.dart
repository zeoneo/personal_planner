import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/ScheduleItem.dart';

typedef void NavigationChangedCallback(int selectedItemIndex);

class ScheduleRow extends StatelessWidget {
  ScheduleRow({Key key, this.item}) : super(key: key);

  final ScheduleItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          new Expanded(
            child: Text(
              (new DateFormat.jm()).format(item.startTime),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(fontSize: 10),
            ),
            flex: 3,
          ),
          new Expanded(
            child: Text(
              item.itemDetail,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              maxLines: 1,
              style: TextStyle(fontSize: 10),
            ),
            flex: 7,
          ),
        ],
      ),
    );
  }
}
