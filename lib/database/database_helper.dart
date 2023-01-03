import "package:sqflite/sqflite.dart";
import 'package:path/path.dart';

class DBhelper {
  static Future<Database> database() async {
    final databasepath = await getDatabasesPath();
    String dbpath = join(databasepath, "dailyexpense.db");

    return await openDatabase(dbpath, onCreate: (Database db, int version) {
      return db.execute(
          "CREATE TABLE diyexp (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, amount INTEGER, date Text)");
    }, version: 1);
  }

  static Future<void> insert(String title, int amount, String date) async {
    final db = await DBhelper.database();
    db.rawInsert("INSERT INTO diyexp(title,amount,date) VALUES (?,?,?)",
        [title, amount, date]);
  }

  static Future<List<Map<String, dynamic>>> getData(String date) async {
    final db = await DBhelper.database();
    return db.rawQuery(
        "SELECT * FROM diyexp WHERE date = ? ORDER BY id DESC", [date]);
  }

  static Future<List<Map<String, dynamic>>> getsumdb(String date) async {
    final db = await DBhelper.database();
    return db.rawQuery(
        "SELECT sum(amount) as Totalamount FROM diyexp WHERE date = ?", [date]);
  }

  static Future<void> delete(int id) async {
    final db = await DBhelper.database();
    db.rawDelete("DELETE FROM diyexp WHERE id = ?", [id]);
  }

  static Future<List<Map<String, dynamic>>> distinctDateDb() async {
    final db = await DBhelper.database();
    return db.rawQuery("SELECT DISTINCT date FROM diyexp ORDER BY id DESC");
  }
}
