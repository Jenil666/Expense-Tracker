import 'dart:async';

import 'package:databased_first_program/utils/data_based_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextFieldController extends GetxController {
  TextEditingController txtAmount = TextEditingController();
  TextEditingController txtDate = TextEditingController(text: '23-5-23');
  TextEditingController txtTime = TextEditingController(text: '12:00');
  TextEditingController txtCategary = TextEditingController();
  TextEditingController txtPayType = TextEditingController(text: 'online');
  TextEditingController txtStatusCode = TextEditingController(text: '1');
  TextEditingController txtNote = TextEditingController(text: 'mocktail');
  String payType = "";
  int incomeExpense = 2;
  RxList<Map> datas = <Map>[].obs;
  RxList<Map> datasForTotal = <Map>[].obs;
  RxList<Map> totalIncome = <Map>[].obs;
  RxList<Map> totalExpense = <Map>[].obs;
  RxList<Map> category = <Map>[].obs;

  TextEditingController updatedtxtAmount = TextEditingController(text: '200');
  TextEditingController updatedtxtTime = TextEditingController(text: '12:00');
  TextEditingController updatedtxtDate = TextEditingController(text: '12:00');
  TextEditingController updatedtxtCategary = TextEditingController(text: 'food');
  TextEditingController updatedtxtPayType = TextEditingController(text: 'online');
  TextEditingController updatedtxtStatusCode = TextEditingController(text: '1');
  TextEditingController updatedtxtNote = TextEditingController();
  TextEditingController txtuserEntry = TextEditingController();
  TextEditingController txtUpdateCategory = TextEditingController();
  String toDate = '';
  String fromDate = '';
  RxString date = ''.obs;
  String userEntry = "";
  DateTime now = DateTime.now();
  DateTime initialDate = DateTime.now();
  RxList<DropdownMenuEntry> listOfEntry = <DropdownMenuEntry>[].obs;
  RxInt dropDownIncomeExpenseFilter = 0.obs;
  RxString dropDownPayType = "online".obs;
  RxString updated = "Jenil".obs;
  Rx<TimeOfDay> time = TimeOfDay.now().obs;
  RxString timeSt = "".obs;
  RxString dropDownValueForayType = "".obs;
  RxString dropDownValueFoDate = "".obs;
  RxInt dropDownValueForIncomeExpense = 1.obs;

  AddDataInlistOfEntry() {
    print("Done");
    print(category);
    Timer(
      Duration(seconds: 2),
      () {
        listOfEntry.clear();
        for (int i = 0; i < category.length; i++) {
          listOfEntry.add(DropdownMenuEntry(
              value: category[i][DataBasedHelper.c_catCategory],
              label: category[i][DataBasedHelper.c_catCategory]));
        }
        print("end");
        print(listOfEntry[0].label);
        print(listOfEntry[0].value);
      },
    );
  }

  Filte({required statusCode,required payType,required toDate}) async {
    print("+++++++++++++++++    Controller");
    print("Inc:- $statusCode");
    print("Onl:- $payType");
    print("Dat:- $toDate");
    datas.value = await DataBasedHelper.dbHelper.Filter(statusCode: statusCode, payType: payType, fromDate: toDate);
    if(toDate == "")
      {
        print("Done");
      }
  }

  // DateWiseFilter({required todate, fromdate}) async {
  //   datas.value = await DataBasedHelper.dbHelper.DateWise(todate,fromdate);
  // }

  double sumForFilters = 0;
  allEntryTotal()
  {
    readDataForTotal();
    sumForFilters = 0;
    for(int i =0; i< datasForTotal.length; i++)
      {
        String value = datasForTotal[i][DataBasedHelper.c_amount];
        int amount = int.parse(value);
        sumForFilters = sumForFilters + amount;
      }
    print("end");
    print(sumForFilters);
  }

  RxDouble sumOfIncome=0.0.obs;
  AllIncomeTotal()
  {
    TotalIncome();
    sumOfIncome.value = 0;
    for(int i = 0; i < totalIncome.length; i++)
      {
        String value = totalIncome[i][DataBasedHelper.c_amount];
        int amount = int.parse(value);
        sumOfIncome.value = sumOfIncome.value + amount;
      }
    // print("SumOfIncome");
    // print(sumOfIncome);
  }

  RxDouble sumOfExpense=0.0.obs;
  AllExpenseTotal()
  {
    TotalExpense();
    sumOfExpense.value = 0;
    for(int i = 0; i < totalExpense.length; i++)
    {
      String value = totalExpense[i][DataBasedHelper.c_amount];
      int amount = int.parse(value);
      sumOfExpense.value = sumOfExpense.value + amount;
    }
    // print("sumOfExpense");
    // print(sumOfExpense);
  }

  RxDouble grandTotal=0.0.obs;
  GrandTotal()
  {
    grandTotal.value = 0;
    AllIncomeTotal();
    AllExpenseTotal();
    // Timer(Duration(seconds: 0), () {
      grandTotal.value = sumOfIncome.value - sumOfExpense.value;
      print("Income");
      print(sumOfIncome);
      print("Expensw");
      print(sumOfExpense);
      print("grandT");
      print(grandTotal);
    // });

  }

  TotalIncome()
  async {
    totalIncome.value = await DataBasedHelper.dbHelper.FilterForIncone();
  }

  TotalExpense()
  async {
    totalExpense.value = await DataBasedHelper.dbHelper.FilterForExpense();
  }

  Future<void> readDataForTotal() async {
    datasForTotal.value = await DataBasedHelper.dbHelper.read();
  }
  // ToDo All Table

  Future<void> readData() async {
    datas.value = await DataBasedHelper.dbHelper.read();
  }

  DeleteData({id}) {
    DataBasedHelper.dbHelper.Delete(id: id);
    readData();
  }

  Update({required statusCode, required notes, required time, required date, required category, required amount, required id,required payTypes,}) {
    DataBasedHelper.dbHelper.Update(
        statusCode: statusCode,
        notes: notes,
        time: time,
        date: date,
        category: category,
        amount: amount,
        id: id,
        payType: payTypes,
    );
    readData();
  }

  // ToDo Category Table

  Future<void> readCatData() async {
    category.value = await DataBasedHelper.dbHelper.readFoeCat();
    // print('===================================================================================');
    // print(category);
  }

  DeleteDataInCat({id}) {
    DataBasedHelper.dbHelper.CatDelete(id: id);
    readCatData();
  }

  UpdateCat({required id ,required category}) {
    print("==============++++++++++++Controller");
    print("id = $id");
    print(category);
    DataBasedHelper.dbHelper.UpdateAtCatgery(id, category);
    readCatData();
    print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
    print(category);
  }
}