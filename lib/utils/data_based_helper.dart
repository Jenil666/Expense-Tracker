import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBasedHelper {
  static DataBasedHelper dbHelper = DataBasedHelper._();
  DataBasedHelper._();


  // ToDo full Table



  static String tableName = "IncomeExpense";
  static String c_id = "id";
  static String c_amount = "amount";
  static String c_category = "category";
  static String c_notes = "notes";
  static String c_date = "date";
  static String c_time = "time";
  static String c_statusCode = "Statuscode";
  static String c_payType = "payType";
  Database? database;

  Future<Database?> CheckDb() async {
    if (database == null) {
      return await initDb();
    } else {
      return database;
    }
  }

  Future<Database> initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, 'jenildatabased.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String quary =
            'CREATE TABLE $tableName ($c_id INTEGER PRIMARY KEY AUTOINCREMENT,$c_amount TEXT,$c_category TEXT,$c_date TEXT,$c_time TEXT,$c_notes TEXT,$c_statusCode INTEGER,$c_payType TEXT)';
        db.execute(quary);
      },
    );
  }

  creatrCategoryTable() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, 'category.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String quary = 'CREATE TABLE $catTableName ($c_id INTEGER PRIMARY KEY AUTOINCREMENT,$c_catCategory TEXT)';
        db.execute(quary);
      },
    );
  }

  void insertData({
    required statusCode,
    required notes,
    required time,
    required date,
    required category,
    required amount,
    required payType,
  }) async {
    database = await CheckDb();
    database?.insert("$tableName", {
      c_statusCode: statusCode,
      c_notes: notes,
      c_time: time,
      c_date: date,
      c_category: category,
      c_amount: amount,
      c_payType: payType,
    });
    // print();
  }

  Future<List<Map>> read() async {
    database = await CheckDb();
    String qu = "SELECT * FROM $tableName";
    List<Map> listreac = await database!.rawQuery(qu);
    return listreac;
  }


  void Delete({required id}) async {
    database = await CheckDb();
    database?.delete(tableName, where: "$c_id=?", whereArgs: [id]);
  }

  Update(
      {required statusCode,
      required notes,
      required time,
      required date,
      required category,
      required amount,
      required id,
      required payType}) async {
    database = await CheckDb();
    database?.update(
        tableName,
        {
          c_statusCode: statusCode,
          c_notes: notes,
          c_time: time,
          c_date: date,
          c_category: category,
          c_amount: amount,
          c_payType: payType,
        },
        whereArgs: [id],
        where: "$c_id=?");
  }

  Filter({ required statusCode, required payType,required fromDate,}) async {


    if(statusCode != 2 && payType == "all" && fromDate == "")
      {
        database = await CheckDb();
          String qu = "SELECT * FROM $tableName WHERE $c_statusCode = $statusCode";
          List<Map> listreac = await database!.rawQuery(qu);
          return listreac;
      }
    else if(statusCode == 2 && payType != "all" && fromDate == "")
      {
        database = await CheckDb();
          String qu = "SELECT * FROM $tableName WHERE $c_payType = '$payType'";
          List<Map> listreac = await database!.rawQuery(qu);
          return listreac;
      }
    else if(statusCode == 2 && payType == "all" && fromDate != "")
      {
        String qu = "SELECT * FROM $tableName WHERE $c_date = '$fromDate'";
        List<Map> listreac = await database!.rawQuery(qu);
        return listreac;
      }
    else if(statusCode != 2 && payType == "all" && fromDate != "")
      {
        String qu = "SELECT * FROM $tableName WHERE $c_date = '$fromDate' AND $c_statusCode = $statusCode";
        List<Map> listreac = await database!.rawQuery(qu);
        return listreac;
      }
    else if(statusCode == 2 && payType != "all" && fromDate != "")
    {
      String qu = "SELECT * FROM $tableName WHERE $c_date = '$fromDate' AND $c_payType = '$payType'";
      List<Map> listreac = await database!.rawQuery(qu);
      return listreac;
    }
    else if (statusCode != 2 && payType != 'all' && fromDate == "") {
        database = await CheckDb();
        String qu = "SELECT * FROM $tableName WHERE $c_payType = '$payType' AND $c_statusCode = '$statusCode'";
        List<Map> listreac = await database!.rawQuery(qu);
        return listreac;
      }
    else if(statusCode != 2 && payType != 'all' && fromDate != "")
      {
        String qu = "SELECT * FROM $tableName WHERE $c_date = '$fromDate' AND $c_payType = '$payType' AND $c_statusCode = '$statusCode'";
        List<Map> listreac = await database!.rawQuery(qu);
        return listreac;
      }
    else if(statusCode == 2 && payType == 'all' && fromDate == "")
    {
      read();
    }
    // print("+++++++++++++++++    DB HELPER");
    // print("status code $statusCode");
    // print("payType $payType");
    // if (statusCode != 2 && payType == 'all') {
    //   // print("Status Code Method");
    //
    // }
    // else if (statusCode == 2 && payType != 'all') {
    //   // print("Pay type Method");
    //
    // }
    //
    // else if(fromDate != null && fromDate != null)
    //   {
    //     String qu = "SELECT * FROM $tableName where $c_date >= '18-5-2023' and $c_date <= '19-5-2023'";
    //     List<Map> listreac = await database!.rawQuery(qu);
    //     return listreac;
    //   }
  }


  FilterForIncone()
  async {
    database = await CheckDb();
    String qu = "SELECT * FROM $tableName WHERE $c_statusCode = '0'";
    List<Map> listreac = await database!.rawQuery(qu);
    print("Db Helper");
    print("$listreac");
    return listreac;
  }

  FilterForExpense()
  async {
    database = await CheckDb();
    String qu = "SELECT * FROM $tableName WHERE $c_statusCode = '1'";
    List<Map> listreac = await database!.rawQuery(qu);
    return listreac;
  }
  // ToDo Category Table

  static String c_catCategory = "category";
  static String c_catid = "id";
  static String catTableName = "category";
  Database? catDatabase;

  CheckDbForCat() async {
    if (catDatabase == null) {
      return await creatrCategoryTable();
    } else {
      return catDatabase;
    }
  }

  readFoeCat() async {
    catDatabase = await CheckDbForCat();
    String qu = "SELECT * FROM $catTableName";
    List<Map> listreac = await catDatabase!.rawQuery(qu);
    return listreac;
  }

  void CatDelete({required id}) async {
    catDatabase = await CheckDbForCat();
    catDatabase?.delete(catTableName, where: "$c_catid=?", whereArgs: [id]);
  }

  insertDateInCategoryTable({required category}) async {
    catDatabase = await CheckDbForCat();
    catDatabase?.insert(
      catTableName,
      {
        c_catCategory: category,
      },
    );
  }

  UpdateAtCatgery(id,category)
  async {
    print("++++++++++++++++++++Helper");
    print(category);
    catDatabase = await CheckDbForCat();
    catDatabase?.update(catTableName,{
      c_catCategory: category,
    } ,where:"$c_catid=?" ,whereArgs: [id],);
  }
}
