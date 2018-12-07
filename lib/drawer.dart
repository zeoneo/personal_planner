import 'package:flutter/material.dart';

typedef void NavigationChangedCallback(int selectedItemIndex);

class AppDrawer extends StatelessWidget {
  AppDrawer({Key key, this.selectedItem, this.onNavigationChanged})
      : super(key: key);

  final int selectedItem;
  final NavigationChangedCallback onNavigationChanged;

  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: new Text("Prakash"),
            accountEmail: new Text("praks@gmail.com"),
            currentAccountPicture: new CircleAvatar(
                backgroundColor: Colors.brown, child: new Text("Acc")),
          ),
          ListTile(
            title: Text('Daily Planner'),
            selected: selectedItem == 0,
            onTap: () {
              onNavigationChanged(0);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Monthly Planner'),
            selected: selectedItem == 1,
            onTap: () {
              onNavigationChanged(1);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Annual Planner'),
            selected: selectedItem == 2,
            onTap: () {
              onNavigationChanged(2);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
