import 'package:flutter/material.dart';
import 'daily_planner_view/schedule_component.dart';
import 'daily_planner_view/goals_view.dart';
import 'daily_planner_view/todo_view.dart';
import 'daily_planner_view/motivation_view.dart';

class Schedule {
  const Schedule(
      {this.itemDetail, this.startTime, this.endTime, this.isCompleted});
  final String itemDetail;
  final DateTime startTime;
  final DateTime endTime;
  final bool isCompleted;
}

class Todo {
  const Todo({this.itemDetails, this.isCompleted});
  final String itemDetails;
  final bool isCompleted;
}

class Goal {
  const Goal({this.itemDetails, this.isCompleted});
  final String itemDetails;
  final bool isCompleted;
}

class DailyPlanner extends StatefulWidget {
  DailyPlanner({Key key}) : super(key: key);

  List<Todo> todos;
  List<Schedule> scheduleItems;
  List<Goal> goals;

  @override
  DailyPlannerState createState() {
    return new DailyPlannerState();
  }
}

class DailyPlannerState extends State<DailyPlanner> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20.0),
      crossAxisSpacing: 10.0,
      crossAxisCount: 2,
      children: <Widget>[
        new ScheduleComponent(),
        new GoalsView(),
        new TodoView(),
        new MotivationView(),
      ],
    );
  }
}
