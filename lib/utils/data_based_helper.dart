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
  static String c_month = "month";
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
            'CREATE TABLE $tableName ($c_id INTEGER PRIMARY KEY AUTOINCREMENT,$c_amount TEXT,$c_category TEXT,$c_date TEXT,$c_time TEXT,$c_notes TEXT,$c_statusCode INTEGER,$c_payType TEXT,$c_month TEXT)';
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
    required month,
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
      c_month: month,
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
      required payType,
        required month
      }) async {
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
          c_month: month,
        },
        whereArgs: [id],
        where: "$c_id=?");
  }

  Filter({ required statusCode, required payType,required fromDate,required month}) async {
    print(" ============================  helper");
    print('statusCode  $statusCode');
    print('payType  $payType');
    print('fromDate  $fromDate');
    print('month  $month');

    // ToDo Single paramaters
    if(statusCode != 2 && month == 14 && payType == "all" && fromDate == "")
      {
        database = await CheckDb();
          String qu = "SELECT * FROM $tableName WHERE $c_statusCode = '$statusCode'";
          List<Map> listreac = await database!.rawQuery(qu);
          print("Map Map");
          print(listreac);
          return listreac;
      }
    else if(month != 14&& statusCode == 2 && payType == "all" && fromDate == "")
      {
        database = await CheckDb();
        String qu = "SELECT * FROM $tableName WHERE $c_month = '$month'";
        List<Map> listreac = await database!.rawQuery(qu);
        print("Map single");
        print(listreac);
        return listreac;
      }
    else if(payType != "all" && month == 14 && statusCode == 2 && fromDate == "")
      {
        database = await CheckDb();
        print("======================   Method");
        print("Pay  Type = $payType");
          String qu = "SELECT * FROM $tableName WHERE $c_payType = '$payType'";
          List<Map> listreac = await database!.rawQuery(qu);
          return listreac;
      }
    else if(fromDate != "" && payType == "all" && month == 14 && statusCode == 2 )
      {
        print("c_date = $c_date");
        String qu = "SELECT * FROM $tableName WHERE $c_date = '$fromDate'";
        List<Map> listreac = await database!.rawQuery(qu);
        return listreac;
      }



    // ToDo 2 paramaters
    else if(statusCode != 2 && month != 14 && fromDate == "" && payType == "all")
      {
        String qu = "SELECT * FROM $tableName WHERE $c_month = '$month' AND $c_statusCode = $statusCode";
        List<Map> listreac = await database!.rawQuery(qu);
        return listreac;
      }
    else if(statusCode != 2 && payType != "all" && fromDate == ""  && month == 14 )
      {
        String qu = "SELECT * FROM $tableName WHERE $c_statusCode = $statusCode AND $c_payType = '$payType'";
        List<Map> listreac = await database!.rawQuery(qu);
        // print("Map");
        // print(listreac);
        return listreac;
      }
    else if(statusCode != 2 && fromDate != "" && payType == "all" && month == 14 )
    {
      String qu = "SELECT * FROM $tableName WHERE $c_statusCode = '$statusCode' AND $c_date = '$fromDate'";
      List<Map> listreac = await database!.rawQuery(qu);
      print("Map 4 ");
      print(listreac);
      return listreac;
    }
    else if( payType != "all"  && month != 14 && fromDate == "" && statusCode == 2)
    {
      String qu = "SELECT * FROM $tableName WHERE $c_payType = '$payType' AND $c_month = '$month'";
      List<Map> listreac = await database!.rawQuery(qu);
      return listreac;
    }
    else if(payType != "all" && fromDate != "" && month == 14 && statusCode == 2 )
    {
      String qu = "SELECT * FROM $tableName WHERE $c_date = '$fromDate' AND $c_payType = '$payType'";
      List<Map> listreac = await database!.rawQuery(qu);
      return listreac;
    }
    else if (statusCode != 2 && payType != 'all'&& fromDate == ""  && month == 14  )
    {
        // database = await CheckDb();
        String qu = "SELECT * FROM $tableName WHERE $c_payType = '$payType' AND $c_statusCode = '$statusCode'";

        List<Map> listreac = await database!.rawQuery(qu);
        return listreac;
      }
    else if(payType != 'all' && fromDate != "" && month == 14 && statusCode == 2 )
      {
        String qu = "SELECT * FROM $tableName WHERE $c_date = '$fromDate' AND $c_payType = '$payType'";
        List<Map> listreac = await database!.rawQuery(qu);
        return listreac;
      }
    else if(statusCode != 2 && fromDate != "" && payType == "all" && month == 14 )
      {
        String qu = "SELECT * FROM $tableName WHERE $c_date = '$fromDate' AND $c_statusCode = '$statusCode'";
        List<Map> listreac = await database!.rawQuery(qu);
        return listreac;
      }
    else if(payType != 'all' && month != 14 && fromDate == ""  && statusCode == 2 )
    {
      String qu = "SELECT * FROM $tableName WHERE $c_month = '$month' AND $c_payType = '$payType'";
      List<Map> listreac = await database!.rawQuery(qu);
      return listreac;
    }
    else if(statusCode != 2 && month != 14 && fromDate == "" && payType == "all" )
    {
      String qu = "SELECT * FROM $tableName WHERE $c_month = '$month' AND $c_statusCode = '$statusCode'";
      List<Map> listreac = await database!.rawQuery(qu);
      return listreac;
    }
    else if(fromDate != "" && month != 14 && statusCode == 2 && payType == "all" )
    {
      String qu = "SELECT * FROM $tableName WHERE $c_month = '$month' AND $c_date = '$fromDate'";
      List<Map> listreac = await database!.rawQuery(qu);
      return listreac;
    }

    // ToDo 3 paramaters
    else if(statusCode != 2 && payType != 'all' && fromDate != "" && month == 14)
    {
      String qu = "SELECT * FROM $tableName WHERE $c_date = '$fromDate' AND $c_payType = '$payType' AND $c_statusCode = '$statusCode'";
      List<Map> listreac = await database!.rawQuery(qu);
      return listreac;
    }

    else if(statusCode != 2 && payType != 'all'  && month != 14 && fromDate == "")
    {
      String qu = "SELECT * FROM $tableName WHERE $c_date = '$fromDate' AND $c_month = '$month' AND $c_statusCode = '$statusCode'";
      List<Map> listreac = await database!.rawQuery(qu);
      return listreac;
    }
    else if(statusCode != 2  && fromDate != "" && month != 14 && payType == 'all')
    {
      String qu = "SELECT * FROM $tableName WHERE $c_date = '$fromDate' AND $c_month = '$month' AND $c_statusCode = '$statusCode'";
      List<Map> listreac = await database!.rawQuery(qu);
      return listreac;
    }

    else if( payType != 'all' && fromDate != "" && month != 14 && statusCode == 2)
    {
      String qu = "SELECT * FROM $tableName WHERE $c_date = '$fromDate' AND $c_month = '$month' AND $c_payType = '$payType'";
      List<Map> listreac = await database!.rawQuery(qu);
      return listreac;
    }


    // ToDo 4 paramaters
    else if(statusCode != 2 && payType != 'all' && fromDate != "" && month != 14)
    {
      String qu = "SELECT * FROM $tableName WHERE $c_date = '$fromDate' AND $c_payType = '$payType' AND $c_statusCode = '$statusCode' AND $c_month = '$month'";
      List<Map> listreac = await database!.rawQuery(qu);
      print("====================== 4P");
      print(listreac);
      return listreac;
    }
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
