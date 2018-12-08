import 'package:flutter/material.dart';

class ScheduleItem {
  const ScheduleItem({
    Key key,
    @required this.itemDetail,
    @required this.startTime,
    @required this.endTime,
    @required this.documentKey,
  });
  final String itemDetail;
  final DateTime startTime;
  final DateTime endTime;
  final String documentKey;
}
