import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import '../database/getdata.dart';
import '../widgets/totalcurrentcount.dart';

class HistoryList extends StatelessWidget {
  final String date;
  const HistoryList({required this.date});

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("Transaction Lists for $date"),
      ),
      body: SizedBox(
        width: deviceWidth,
        height: deviceHeight,
        child: Column(
          children: <Widget>[
            Material(
              elevation: 5,
              child: Container(
                width: deviceWidth * 1,
                height: deviceHeight * 0.07,
                decoration: const BoxDecoration(
                  color: Colors.yellow,
                ),
                child: TotalCurrentCount(
                  date: date,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                width: deviceWidth * 0.97,
                decoration: const BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 3.0,
                        spreadRadius: 1.0,
                      ),
                    ]),
                child: FutureBuilder(
                  future: Provider.of<MainData>(context, listen: false)
                      .getandsetdb(date),
                  builder: (ctx, futuresnapshot) => futuresnapshot
                              .connectionState ==
                          ConnectionState.waiting
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Consumer<MainData>(
                          child: const Center(
                            child: Text("Got no Data. Add some..."),
                          ),
                          builder: (ctx, main, ch) => main.Dummy_Data.isEmpty
                              ? ch!
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: ListView.separated(
                                    itemCount: main.Dummy_Data.length,
                                    itemBuilder: (ctx, index) {
                                      return Container(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            backgroundColor: Colors.yellow[300],
                                            child: Text(
                                              (main.Dummy_Data.length - index)
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20),
                                            ),
                                          ),
                                          title: Container(
                                            padding: const EdgeInsets.only(bottom: 8),
                                            child: Text(
                                              main.Dummy_Data[index].title,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          subtitle: Text(
                                            "${main.Dummy_Data[index].amount} Ks",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: main.Dummy_Data[index]
                                                      .amount.isNegative
                                                  ? Colors.red
                                                  : Colors.green,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (ctx, index) => const Divider(
                                      thickness: 2,
                                    ),
                                  ),
                                )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
