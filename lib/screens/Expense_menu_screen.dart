import 'package:dailyexpenses/widgets/all_grid.dart';
import 'package:dailyexpenses/widgets/today_container.dart';
import "package:flutter/material.dart";

class ExpenseMenuScreen extends StatefulWidget {

  @override
  State<ExpenseMenuScreen> createState() => _ExpenseMenuScreenState();
}

class _ExpenseMenuScreenState extends State<ExpenseMenuScreen> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "My Daily Expenses",
      )),
      body: SizedBox(
        height: deviceHeight,
        width: deviceWidth,
        child: Column(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              margin: const EdgeInsets.symmetric(vertical: 20),
              height: deviceHeight * 0.17,
              width: deviceWidth * 0.85,
              child: TodayContainer(),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: AllGrid(),
                  ),
                  Positioned(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      color: Colors.red.withOpacity(0.2),
                      child: const Text(
                        "Tap the box to check the History in Details",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
