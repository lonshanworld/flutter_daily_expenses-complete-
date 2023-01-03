import 'package:dailyexpenses/widgets/totalcurrentcount.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../database/getdata.dart';

class UserInput extends StatefulWidget {
  static const routename = "userinput_screen";


  @override
  State<UserInput> createState() => _UserInputState();
}

class _UserInputState extends State<UserInput> {
  List<String> typenum = ["+", "-"];
  String selectedtypenum = "+";

  final _titlecontroller = TextEditingController();
  final _amountcontroller = TextEditingController();
  void _submitDate() {
    final name = _titlecontroller.text;
    final amount = _amountcontroller.text;

    if (name.isEmpty || amount.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please Enter the text")),
      );
    } else {
      setState(() {
        final newname = (name).toString();
        final newamount = int.parse(amount);

        if (selectedtypenum == "+") {
          Provider.of<MainData>(context, listen: false)
              .addData(newname, newamount);
        } else if (selectedtypenum == "-") {
          Provider.of<MainData>(context, listen: false)
              .addData(newname, (-1) * newamount);
        }
      });

      _titlecontroller.clear();
      _amountcontroller.clear();
      selectedtypenum = "+";
    }
  }

  @override
  Widget build(BuildContext context) {
    final devicewidth = MediaQuery.of(context).size.width;
    final deviceheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Today Usage"),
      ),
      body: SizedBox(
        height: deviceheight,
        width: devicewidth,
        child: Column(
          children: <Widget>[
            Material(
              elevation: 5,
              child: Container(
                width: devicewidth * 1,
                height: deviceheight * 0.07,
                decoration: const BoxDecoration(
                  color: Colors.yellow,
                ),
                child: TotalCurrentCount(
                  date: DateFormat("dd-MMMM-yyyy")
                      .format(DateTime.now())
                      .toString(),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              height: deviceheight * 0.27,
              width: devicewidth * 0.95,
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: const InputDecoration(
                        labelText: "Things you used your money on"),
                    controller: _titlecontroller,
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: devicewidth * 0.15,
                        child: DropdownButton<String>(
                          value: selectedtypenum,
                          items: typenum
                              .map((e) => DropdownMenuItem<String>(
                                    value: e,
                                    child: Text(
                                      e,
                                      style: const TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (e) => setState(() {
                            selectedtypenum = e!;
                          }),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "Amount",
                          ),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          controller: _amountcontroller,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 13),
                    child: OutlinedButton(
                      onPressed: _submitDate,
                      style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.yellow[700],
                          textStyle: const TextStyle(fontSize: 20),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          side: BorderSide(
                              width: 2, color: Colors.yellow.shade700)),
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("Submit"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: devicewidth * 0.97,
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
                      .getandsetdb(DateFormat("dd-MMMM-yyyy")
                          .format(DateTime.now())
                          .toString()),
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
                                          trailing: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                main.deleteData(
                                                    main.Dummy_Data[index].id);
                                              });
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.red),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                              ),
                                            ),
                                            child: SizedBox(
                                              width: devicewidth * 0.205,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: const <Widget>[
                                                  Text(
                                                    "Delete",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.white),
                                                  ),
                                                  Icon(
                                                    Icons.delete_forever,
                                                    size: 22,
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              ),
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
