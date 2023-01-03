import "package:flutter/material.dart";

import 'package:intl/intl.dart';

import '../database/database_helper.dart';
import '../models/data.dart';

class MainData with ChangeNotifier {
  //for list
  List<Datainput> _Dummy_Data = [];

  List<Datainput> get Dummy_Data {
    return [..._Dummy_Data];
  }

  Future<void> addData(String title, int amount) async {
    _Dummy_Data.add(Datainput(
        id: 0,
        title: title,
        amount: amount,
        date: DateFormat("dd-MMMM-yyyy").format(DateTime.now()).toString()));
    notifyListeners();
    await DBhelper.insert(title, amount,
        DateFormat("dd-MMMM-yyyy").format(DateTime.now()).toString());
  }

  Future<void> deleteData(int id) async {
    _Dummy_Data.removeWhere((element) => element.id == id);
    notifyListeners();
    await DBhelper.delete(id);
  }

  Future<void> getandsetdb(String date) async {
    final dblist = await DBhelper.getData(date);
    _Dummy_Data = dblist
        .map((e) => Datainput(
            id: e["id"],
            title: e["title"],
            amount: e["amount"],
            date: e["date"]))
        .toList();
    notifyListeners();
  }


  int _sumtotal = 0;
  int get sumtotal{
    return _sumtotal;
  }
  //for sum
  Future<int> getsum(String date) async {
    final getsumprint = await DBhelper.getsumdb(date);
    if (getsumprint[0]["Totalamount"] == null) {
      if(date == DateFormat("dd-MMMM-yyyy").format(DateTime.now()).toString()){
        _sumtotal = 0;
        return 0;
      }else{
        return 0;
      }
    } else {
      if(date == DateFormat("dd-MMMM-yyyy").format(DateTime.now()).toString()){
        _sumtotal = getsumprint[0]["Totalamount"];
        return getsumprint[0]["Totalamount"];
      }else{
        return getsumprint[0]["Totalamount"];
      }
    }
  }

  //for date
  List<Datelist> _Datelistdata = [];

  List<Datelist> get Datelistdata {
    return [..._Datelistdata];
  }

  Future<void> getandsetdatedb() async {
    final dblist = await DBhelper.distinctDateDb();
    _Datelistdata = dblist.map((e) => Datelist(date: e["date"])).toList();
    notifyListeners();
  }
}
