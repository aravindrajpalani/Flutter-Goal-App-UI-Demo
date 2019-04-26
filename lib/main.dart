import 'package:flutter/material.dart';
import 'package:goal_app/screen/homeScreen.dart';
import 'package:goal_app/screen/set_goal_screen.dart';
import 'package:goal_app/screen/splashScreen.dart';

void main() {
  runApp(new MaterialApp(
    home: new SplashScreen(),
    routes: <String, WidgetBuilder>{
      '/HomeScreen': (BuildContext context) => HomeScreen(),
      '/SetGoalScreen': (BuildContext context) => SetGoalScreen()
    },
  ));
}
