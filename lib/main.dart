import 'package:dailyexpenses/screens/Expense_menu_screen.dart';

import 'package:dailyexpenses/screens/userinput_screen.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import 'database/getdata.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: MainData(),
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: Colors.purple[700],
          ),
        ),
        title: "MY DAILY EXPENSES",
        initialRoute: "/main",
        routes: {
          "/main": (xx) => ExpenseMenuScreen(),
          UserInput.routename: (yy) => UserInput(),
        },
      ),
    );
  }
}
