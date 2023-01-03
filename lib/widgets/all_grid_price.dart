import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import '../database/getdata.dart';

class All_grid_price extends StatelessWidget {
  final String date;
  const All_grid_price({required this.date});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<MainData>(context, listen: false).getsum(date),
      builder: (ctx, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Center(
                  child: Text(
                    "${snapshot.data.toString()} Ks",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: int.parse(snapshot.data.toString()).isNegative
                            ? Colors.red
                            : Colors.green),
                  ),
                ),
    );
  }
}
