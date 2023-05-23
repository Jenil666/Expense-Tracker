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
    getxTextEditingController.date.value = "${getxTextEditingController.now.day}-${getxTextEditingController.now.month}-${getxTextEditingController.now.year}";
    getxTextEditingController.readCatData();
    getxTextEditingController.AddDataInlistOfEntry();
    getxTextEditingController.timeSt.value = "${getxTextEditingController.time.value.hour}:${getxTextEditingController.time.value.minute}";
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black45,
        appBar: AppBar(
          backgroundColor: Color(0xff434273),
          leading: IconButton(onPressed: () {
            getxTextEditingController.readData();
            Get.back();
          }, icon: Icon(Icons.arrow_back)),
          title: Text("Add transction"),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Get.defaultDialog(
                    content: Container(
                      height: 200,
                      width: 60.w,
                      child: ListView(
                        children: [
                          TextField(
                            controller: getxTextEditingController.txtuserEntry,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black45),
                              ),
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                DataBasedHelper.dbHelper.insertDateInCategoryTable(category: getxTextEditingController.txtuserEntry.text);
                                getxTextEditingController.readCatData();
                                getxTextEditingController.AddDataInlistOfEntry();
                                getxTextEditingController.txtuserEntry.clear();
                                // setState(() {});
                                Get.back();
                              },
                              child: Text("Add")),
                          ElevatedButton(onPressed: () {
                            Get.toNamed("/categoryCurd");
                          }, child: Text("Edit CateGory"))
                        ],
                      ),
                    ),
                  );
                },style: ElevatedButton.styleFrom(backgroundColor: Color(0xff434273)),
                child: Text("Add"))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 20.5.w,
                        height: 8.w,
                        color: Colors.blue,
                        alignment: Alignment.center,
                        child: Text("Expense",style: TextStyle(fontSize: 17),),
                      ),
                      Container(
                        width: 20.5.w,
                        height: 8.w,
                        color: Colors.amber,
                        alignment: Alignment.center,
                        child: Text("Income",style: TextStyle(fontSize: 17),),
                      ),
                    ],
                  ),
                  txtField(txtController: getxTextEditingController.txtAmount, txtHintText: 'Amount'),
                  Obx(
                    () =>  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        DropdownMenu(
                          onSelected: (value)  {
                            getxTextEditingController.txtCategary.text = value!;
                          },
                            enableSearch: false,
                            enableFilter: false,
                            // enabled: true,
                            // enabled: false,
                            label: getxTextEditingController.listOfEntry.isEmpty
                                ? Text("Add Items")
                                : Text("Seletc Items",style: TextStyle(fontSize: 12),),
                            dropdownMenuEntries: getxTextEditingController.listOfEntry),
                      ],
                    ),
                  ),
                  SizedBox(height: 0.8.h,),
                  Container(
                    padding: EdgeInsets.all(10),
                    height: 8.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black45),
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Row(
                      children: [
                        Obx(() =>  Text("${getxTextEditingController.date}")),
                        Spacer(),
                        IconButton(onPressed: () async {
                          DateTime? date = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2001,1,1), lastDate: DateTime(2050,1,1));
                          getxTextEditingController.date.value = "${date?.day}-${date?.month}-${date?.year}";
                          print(getxTextEditingController.date);
                          if(getxTextEditingController.date.value == "null-null-null")
                            {
                              getxTextEditingController.date.value = "${getxTextEditingController.now.day}-${getxTextEditingController.now.month}-${getxTextEditingController.now.year}";
                            }
                          // Text("${getxTextEditingController.date}");
                        }, icon: Icon(Icons.calendar_month_outlined),),
                      ],
                    ),
                  ),
                  SizedBox(height: 0.8.h,),
                  Container(
                    padding: EdgeInsets.all(10),
                    height: 8.h,
                    width: 100.w,
                    child: Row(
                      children: [
                        Obx(() =>  Text("${getxTextEditingController.timeSt}")),
                        Spacer(),
                        IconButton(onPressed: () async {
                          TimeOfDay? time = await showTimePicker(context: context, initialTime: TimeOfDay.now(),);
                          getxTextEditingController.timeSt.value = "${time?.hour}:${time?.minute}";
                          print("${getxTextEditingController.timeSt}");
                          if(getxTextEditingController.timeSt.value == "null:null") {
                            getxTextEditingController.timeSt.value = "${getxTextEditingController.time.value.hour}:${getxTextEditingController.time.value.minute}";
                          }
                          // Text("${getxTextEditingController.date}");
                        }, icon: Icon(Icons.timelapse),),
                      ],
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45),
                        borderRadius: BorderRadius.circular(5)
                    ),
                  ),
                  SizedBox(height: 0.8.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownMenu(
                          menuStyle: MenuStyle(visualDensity: VisualDensity.adaptivePlatformDensity),
                          onSelected: (value) {
                            // print(value);
                            getxTextEditingController.payType = value!;
                          },
                          hintText: "PayType",
                          dropdownMenuEntries: [
                            DropdownMenuEntry(value: "online", label: "Online"),
                            DropdownMenuEntry(value: "offline", label: "Offline"),
                          ]),
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
                    ],
                  ),
                  txtField(txtController: getxTextEditingController.txtNote, txtHintText: 'Notes'),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        int amountToCheck = 0;
                        try {
                          amountToCheck = int.parse(getxTextEditingController.txtAmount.text);
                        } catch (e, s) {
                          Get.snackbar("Khata Book App", "Enter Proper Amount");
                        }
                        // &&
                        print('======================================================');
                        print(getxTextEditingController.payType);
                        if((getxTextEditingController.incomeExpense == 0 || getxTextEditingController.incomeExpense == 1) && (amountToCheck > 0) && (getxTextEditingController.txtCategary.text != "") && (getxTextEditingController.payType == 'online' || getxTextEditingController.payType == 'offline')) {
                          int status = getxTextEditingController.incomeExpense;
                          String note = getxTextEditingController.txtNote.text; //done
                          String time = getxTextEditingController.timeSt.value; //done
                          String date = getxTextEditingController.date.value; // done
                          String category = getxTextEditingController.txtCategary.text; //done
                          String amount = getxTextEditingController.txtAmount.text; // done
                          String payType = getxTextEditingController.payType; //done
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
                          // getxTextEditingController.txtTime.clear();
                          // getxTextEditingController.txtDate.clear();
                          getxTextEditingController.txtAmount.clear();
                          // getxTextEditingController.txtPayType.clear();
                          // getxTextEditingController.txtCategary.clear();
                        }
                        else
                          {
                            Get.snackbar("Khata Book App", "Enter Required Paramaters");
                          }
                      },
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
  Widget txtField({txtController, txtHintText}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        controller: txtController,
        decoration: InputDecoration(
          hintText: txtHintText,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
