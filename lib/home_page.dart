import 'package:flutter/material.dart';

import 'drawer.dart';
import 'daily_planner.dart';
import 'annual_planner.dart';
import 'monthly_planner.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedPlanner = 0;
  List<String> titles = ["Daily Planner", "Monthly Planner", "Annual Planner"];

  void _setSelectedPlanner(int _index) {
    setState(() {
      _selectedPlanner = _index;
      _getDrawerItemScreen(_index);
    });
  }

  _getDrawerItemScreen(_selectedItem) {
    var screen;
    switch (_selectedItem) {
      case 1:
        screen = MonthlyPlanner();
        break;
      case 2:
        screen = AnnualPlanner();
        break;
      default:
        screen = DailyPlanner();
    }
    return screen;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[_selectedPlanner]),
      ),
      body: _getDrawerItemScreen(_selectedPlanner),
      drawer: AppDrawer(
          selectedItem: _selectedPlanner,
          onNavigationChanged: _setSelectedPlanner),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
