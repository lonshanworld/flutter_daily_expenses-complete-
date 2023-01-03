import "package:flutter/material.dart";

import 'package:provider/provider.dart';

import '../database/getdata.dart';

class TotalCurrentCount extends StatelessWidget {
  final String date;
  const TotalCurrentCount({required this.date});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        const Text(
          "Total Spent : ",
          style: TextStyle(fontSize: 22),
        ),
        FutureBuilder(
          future: Provider.of<MainData>(context, listen: false).getsum(date),
          builder: (ctx, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Center(
                      child: Text("${snapshot.data.toString()} Ks",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color:
                                  int.parse(snapshot.data.toString()).isNegative
                                      ? Colors.red
                                      : Colors.green)),
                    ),
        ),
      ],
    );
  }
}
