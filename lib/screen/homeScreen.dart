import 'package:flutter/material.dart';
import 'package:goal_app/bottomappbar/fab_bottom_app_bar.dart';
import 'package:goal_app/screen/goal_list_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  String _lastSelected = 'TAB: 0';
  int _selectedIndex = 0;

  var _homeWidgetList = [GoalListScreen(), Text('Settings')];
  void _selectedTab(int index) {
    setState(() {
      _lastSelected = 'TAB: $index';
      _selectedIndex = index;
    });
  }

  void _selectedFab(int index) {
    setState(() {
      _lastSelected = 'FAB: $index';
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: _homeWidgetList[_selectedIndex],
      bottomNavigationBar: FABBottomAppBar(
        color: Colors.grey,
        selectedColor: Colors.red,
        notchedShape: CircularNotchedRectangle(),
        onTabSelected: _selectedTab,
        items: [
          FABBottomAppBarItem(
              iconAsset: Image.asset(
            'images/home_selected.png',
            height: 34,
            width: 34,
            color: _selectedIndex == 0 ? Color(0xff013ca6) : Colors.black54,
          )),
          FABBottomAppBarItem(
              iconAsset: Image.asset('images/settings_unselected.png',
                  height: 34,
                  width: 34,
                  color:
                      _selectedIndex == 1 ? Color(0xff013ca6) : Colors.black54))
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/SetGoalScreen');
        },
        tooltip: '',
        child: Icon(Icons.add),
        elevation: 2.0,
      ),
    ));
  }
}
