import 'package:databased_first_program/utils/data_based_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controller/add_screen_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextFieldController getxTextEditingController =
      Get.put(TextFieldController());

  @override
  void initState() {
    // TODO: implement initState
    getxTextEditingController.date.value =
        "${getxTextEditingController.now.day}-${getxTextEditingController.now.month}-${getxTextEditingController.now.year}";
    getxTextEditingController.readCatData();
    getxTextEditingController.AddDataInlistOfEntry();
    getxTextEditingController.timeSt.value =
        "${getxTextEditingController.time.value.hour}:${getxTextEditingController.time.value.minute}";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black45,
        appBar: AppBar(
          backgroundColor: Color(0xff434273),
          leading: IconButton(
              onPressed: () {
                getxTextEditingController.readData();
                Get.back();
              },
              icon: Icon(Icons.arrow_back)),
          title: Text("Add transction"),
          actions: [
            IconButton(onPressed: () {
              Get.defaultDialog(
                backgroundColor: Colors.black,
                title: "Category",
                titleStyle: TextStyle(color: Colors.white),
                content: Container(
                  height: 200,
                  width: 60.w,
                  child: ListView(
                    children: [
                      TextField(
                        controller: getxTextEditingController.txtuserEntry,
                        style: TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          // disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          // label: Text(
                          //   "",
                          //   style: TextStyle(color: Colors.white),
                          // ),
                        ),
                      ),
                      SizedBox(height: 2.h,),
                      ElevatedButton(
                          onPressed: () {
                            if(getxTextEditingController.txtuserEntry.text !="") {
                              // Get.snackbar("Khata Book", "Categiory add");
                              DataBasedHelper.dbHelper
                                  .insertDateInCategoryTable(
                                  category: getxTextEditingController
                                      .txtuserEntry.text);
                              getxTextEditingController.readCatData();
                              getxTextEditingController
                                  .AddDataInlistOfEntry();
                              getxTextEditingController.txtuserEntry
                                  .clear();
                            }
                            Get.back();
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: Color(0xff434273)),
                          child: Text("Add")),
                      ElevatedButton(
                          onPressed: () {
                            Get.back();
                            Get.toNamed("/categoryCurd");
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: Color(0xff434273)),
                          child: Text("Edit CateGory"))
                    ],
                  ),
                ),
              );
            }, icon: Icon(Icons.add))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 1.h,
                  ),
                  Container(
                    height: 5.h,
                    width: 45.w,
                    decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(6)),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () {
                            getxTextEditingController.expenswTextColor.value =
                                Colors.black;
                            getxTextEditingController.incomeTextColor.value =
                                Colors.white;
                            getxTextEditingController.incomeContainerColor
                                .value = Colors.transparent;
                            getxTextEditingController
                                .expenseContainerColor.value = Colors.white60;
                            getxTextEditingController.incomeExpense = 1;
                          },
                          child: Obx(
                            () => Container(
                              width: 20.5.w,
                              height: 8.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: getxTextEditingController
                                      .expenseContainerColor.value,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                "Expense",
                                style: TextStyle(
                                    fontSize: 17,
                                    color: getxTextEditingController
                                        .expenswTextColor.value),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 1.5.w,
                        ),
                        InkWell(
                          onTap: () {
                            getxTextEditingController.expenswTextColor.value =
                                Colors.white;
                            getxTextEditingController.incomeTextColor.value =
                                Colors.black;
                            getxTextEditingController
                                .incomeContainerColor.value = Colors.white60;
                            getxTextEditingController.expenseContainerColor
                                .value = Colors.transparent;
                            getxTextEditingController.incomeExpense = 0;
                          },
                          child: Obx(
                            () => Container(
                              width: 20.5.w,
                              height: 8.w,
                              decoration: BoxDecoration(
                                  color: getxTextEditingController
                                      .incomeContainerColor.value,
                                  borderRadius: BorderRadius.circular(5)),
                              alignment: Alignment.center,
                              child: Text(
                                "Income",
                                style: TextStyle(
                                    fontSize: 17,
                                    color: getxTextEditingController
                                        .incomeTextColor.value),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.white24,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    height: 8.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      // borderRadius: BorderRadius.circular(5)
                    ),
                    child: Row(
                      children: [
                        Obx(() => Text(
                              "${getxTextEditingController.date}",
                              style: TextStyle(color: Colors.white),
                            )),
                        Spacer(),
                        IconButton(
                          onPressed: () async {
                            DateTime? date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2001, 1, 1),
                              lastDate: DateTime(2050, 1, 1),
                              builder: (context, child) {
                                return Theme(
                                    data: Theme.of(context).copyWith(
                                        colorScheme: ColorScheme.light(
                                      primary: Color(0xff535272),
                                    )),
                                    child: child!);
                              },
                            );
                            getxTextEditingController.date.value =
                                "${date?.day}-${date?.month}-${date?.year}";
                            print(getxTextEditingController.date);
                            if (getxTextEditingController.date.value ==
                                "null-null-null") {
                              getxTextEditingController.date.value =
                                  "${getxTextEditingController.now.day}-${getxTextEditingController.now.month}-${getxTextEditingController.now.year}";
                            }
                            // Text("${getxTextEditingController.date}");
                          },
                          icon: Icon(
                            Icons.calendar_month_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h,),
                  TextField(
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      // disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      label: Text(
                        "Amount",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    controller: getxTextEditingController.txtAmount,
                  ),
                  SizedBox(height: 2.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownMenu(
                        textStyle: TextStyle(color: Colors.white),
                        trailingIcon: Icon(Icons.arrow_drop_down_sharp,color: Colors.white,),
                          inputDecorationTheme: InputDecorationTheme(
                            // iconColor: Colors.white,
                            suffixIconColor: Colors.white,
                            prefixIconColor: Colors.white,
                            enabledBorder:  OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            // disabledBorder: OutlineInputBorder(
                            //   borderSide: BorderSide(color: Colors.white),
                            // ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          menuStyle: MenuStyle(
                              visualDensity: VisualDensity.adaptivePlatformDensity),
                          onSelected: (value) {
                            getxTextEditingController.payType = value!;
                          },
                          // hintText: "PayType",
                          label: Text("Pay Type",style: TextStyle(color: Colors.white,fontSize: 13),),
                          dropdownMenuEntries: [
                            DropdownMenuEntry(value: "online", label: "Online"),
                            DropdownMenuEntry(value: "offline", label: "Offline"),
                          ]),
                      Obx(
                            () => Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            DropdownMenu(
                                textStyle: TextStyle(color: Colors.white),
                                trailingIcon: Icon(Icons.arrow_drop_down_sharp,color: Colors.white,),
                                inputDecorationTheme: InputDecorationTheme(
                                  // iconColor: Colors.white,
                                  suffixIconColor: Colors.white,
                                  prefixIconColor: Colors.white,
                                  enabledBorder:  OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  // disabledBorder: OutlineInputBorder(
                                  //   borderSide: BorderSide(color: Colors.white),
                                  // ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                                onSelected: (value) {
                                  getxTextEditingController.txtCategary.text =
                                  value!;
                                },
                                enableFilter: false,
                                label: getxTextEditingController.listOfEntry.isEmpty
                                    ? Text("Add Items",style: TextStyle(color: Colors.white),)
                                    : Text(
                                  "Seletc Items",
                                  style: TextStyle(fontSize: 12,color: Colors.white),
                                ),
                                dropdownMenuEntries:
                                getxTextEditingController.listOfEntry),
                          ],
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 2.h,),
                  Container(
                    padding: EdgeInsets.all(10),
                    height: 8.h,
                    width: 100.w,
                    child: Row(
                      children: [
                        Obx(() => Text("${getxTextEditingController.timeSt}",style: TextStyle(color: Colors.white),)),
                        Spacer(),
                        IconButton(
                          onPressed: () async {
                            TimeOfDay? time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              builder: (context, child) {
                                return Theme(data: ThemeData(colorScheme: ColorScheme.light(
                                  primary: Color(0xff535272),
                                )), child: child!);
                              },
                            );
                            getxTextEditingController.timeSt.value =
                            "${time?.hour}:${time?.minute}";
                            print("${getxTextEditingController.timeSt}");
                            if (getxTextEditingController.timeSt.value ==
                                "null:null") {
                              getxTextEditingController.timeSt.value =
                              "${getxTextEditingController.time.value.hour}:${getxTextEditingController.time.value.minute}";
                            }
                            // Text("${getxTextEditingController.date}");
                          },
                          icon: Icon(Icons.timelapse,color: Colors.white,),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  SizedBox(
                    height: 0.8.h,
                  ),
                  SizedBox(
                    height: 0.8.h,
                  ),
                  SizedBox(
                    height: 0.8.h,
                  ),
                  TextField(
                    controller: getxTextEditingController.txtNote,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      // disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      label: Text(
                        "Note",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 5.h,),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        int amountToCheck = 0;
                        try {
                          amountToCheck = int.parse(
                              getxTextEditingController.txtAmount.text);
                        } catch (e, s) {
                          Get.snackbar("Khata Book App", "Enter Proper Amount");
                        }
                        // &&
                        print(
                            '======================================================');
                        print(getxTextEditingController.payType);
                        if ((getxTextEditingController.incomeExpense == 0 ||
                                getxTextEditingController.incomeExpense == 1) &&
                            (amountToCheck > 0) &&
                            (getxTextEditingController.txtCategary.text !=
                                "") &&
                            (getxTextEditingController.payType == 'online' ||
                                getxTextEditingController.payType ==
                                    'offline')) {
                          int status = getxTextEditingController.incomeExpense;
                          String note =
                              getxTextEditingController.txtNote.text; //done
                          String time =
                              getxTextEditingController.timeSt.value; //done
                          String date =
                              getxTextEditingController.date.value; // done
                          String category =
                              getxTextEditingController.txtCategary.text; //done
                          String amount =
                              getxTextEditingController.txtAmount.text; // done
                          String payType =
                              getxTextEditingController.payType; //done
                          DataBasedHelper.dbHelper.insertData(
                              statusCode: status,
                              notes: note,
                              time: time,
                              date: date,
                              category: category,
                              payType: payType,
                              amount: amount);
                          getxTextEditingController.txtStatusCode.clear();
                          getxTextEditingController.txtNote.clear();
                          getxTextEditingController.txtAmount.clear();
                        } else {
                          Get.snackbar(
                              "Khata Book App", "Enter Required Paramaters");
                        }
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Color(0xff434273)),
                      child: Text("Create"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/*
DropdownMenu(
                          menuStyle: MenuStyle(visualDensity: VisualDensity.adaptivePlatformDensity),
                          onSelected: (value) {
                            getxTextEditingController.incomeExpense = value!;
                            // print(value);
                          },
                          hintText: "Income/Expense",
                          dropdownMenuEntries: [
                            DropdownMenuEntry(value: 0, label: "Income"),
                            DropdownMenuEntry(value: 1, label: "Expense"),
                          ]),
 */
