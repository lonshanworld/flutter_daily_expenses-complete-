import 'package:dailyexpenses/database/getdata.dart';
import 'package:dailyexpenses/screens/history_screen.dart';
import 'package:dailyexpenses/widgets/all_grid_price.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

class AllGrid extends StatefulWidget {

  @override
  State<AllGrid> createState() => _AllGridState();
}

class _AllGridState extends State<AllGrid> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<MainData>(context, listen: false).getandsetdatedb(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<MainData>(
                child: const Center(
                  child: Text("Got no Data. Add some more..."),
                ),
                builder: (ctx, datelist, ch) => datelist.Datelistdata.isEmpty
                    ? ch!
                    : GridView(
                        padding: const EdgeInsets.all(20),
                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 2 / 1,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                        ),
                        children: datelist.Datelistdata.map((e) => InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        HistoryList(date: e.date),
                                  ),
                                );
                              },
                              splashColor: Colors.red,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(10)),
                                  color: Colors.yellow[700],
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Center(
                                      child: Text(
                                        e.date,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Center(
                                      child: All_grid_price(
                                        date: e.date,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )).toList(),
                      ),
              ));
  }
}
