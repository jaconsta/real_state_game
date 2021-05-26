import 'package:flutter/material.dart';

import 'package:real_state_game/screens/main_game.dart';
import 'package:real_state_game/screens/money_screen.dart';
import 'package:real_state_game/screens/movements_history_screen.dart';
import 'package:real_state_game/screens/property_screen.dart';
import 'package:real_state_game/screens/random_card.dart';

void main() {
  runApp(MyApp());
}

var routes = {
  MainGameScreen.id: (context) => MainGameScreen(),
  MoneyScreen.id: (context) => MoneyScreen(),
  PropertyScreen.id: (context) => PropertyScreen(),
  RandomCard.id: (context) => RandomCard(),
  MovementHistoryScreen.id: (context) => MovementHistoryScreen(),
};

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        scaffoldBackgroundColor: Color(0xFFccfd8dc),
      ),
      routes: routes,
      initialRoute: MainGameScreen.id,
    );
  }
}

