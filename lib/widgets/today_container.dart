import 'package:dailyexpenses/screens/userinput_screen.dart';

import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../database/getdata.dart';


class TodayContainer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(UserInput.routename);
      },
      splashColor: Colors.yellow[50],
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Colors.yellow,
        elevation: 10,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                "Today :  ${DateFormat("dd-MMMM-yyyy")
                    .format(DateTime.now())
                    .toString()}",
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                ),
              ),
              FutureBuilder(
                future: Provider.of<MainData>(context, listen: false).getsum(DateFormat("dd-MMMM-yyyy")
                    .format(DateTime.now())
                    .toString()),
                builder: (ctx, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : Center(
                  child: Consumer<MainData>(
                    child: const Center(
                      child: Text("No Data"),
                    ),
                    builder: (ctx, main, ch) => main.sumtotal.isNaN ?
                    ch!
                        :
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text("Transactions :  ",style: TextStyle(fontSize: 20,color: Colors.black),),
                          Text("${main.sumtotal.toString()} Ks",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color:
                                  int.parse(main.sumtotal.toString()).isNegative
                                      ? Colors.red
                                      : Colors.green)),
                        ],
                      )
                    ),
                  ),
                ),
              ),
              const Center(
                child: Text("Tap to insert your transactions",style: TextStyle(fontSize: 14,color: Colors.lightBlue),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
