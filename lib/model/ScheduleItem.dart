class ScheduleItem {
  const ScheduleItem(
      {this.itemDetail, this.startTime, this.endTime, this.isCompleted});
  final String itemDetail;
  final DateTime startTime;
  final DateTime endTime;
  final bool isCompleted;
}
