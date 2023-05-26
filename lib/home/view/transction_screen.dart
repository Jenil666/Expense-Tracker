import 'package:databased_first_program/home/controller/add_screen_controller.dart';
import 'package:databased_first_program/utils/data_based_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../Widget/update_alert_dizlog.dart';

class TransctionScreen extends StatefulWidget {
  const TransctionScreen({Key? key}) : super(key: key);

  @override
  State<TransctionScreen> createState() => _TransctionScreenState();
}

class _TransctionScreenState extends State<TransctionScreen> {
  TextFieldController getxTextEditingController =
      Get.put(TextFieldController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getxTextEditingController.readData();
    getxTextEditingController.readCatData();
    getxTextEditingController.AddDataInlistOfEntry();
    getxTextEditingController.GrandTotal();
    print("================================================");
    // getxTextEditingController.MethodCallToGetValue();
  }

  @override
  Widget build(BuildContext context) {
    getxTextEditingController.dropDownIncomeExpenseFilter.value = 2;
    getxTextEditingController.dropDownPayType.value = "all";
    getxTextEditingController.readData();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          title: Text("Khata Book"),
          actions: [
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: Colors.black,
                  context: context,
                  builder: (context) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 8.h,
                          child: ListView.builder(itemCount: getxTextEditingController.months.length,scrollDirection: Axis.horizontal,itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                print("index $index");
                                getxTextEditingController.indexOfTappedContainer.value = index;
                                getxTextEditingController.Filte(
                                  payType: getxTextEditingController
                                      .dropDownPayType.value,
                                  statusCode: getxTextEditingController
                                      .dropDownIncomeExpenseFilter.value,
                                  toDate: getxTextEditingController.toDate,
                                  month: getxTextEditingController.indexOfTappedContainer.value+1
                                );
                              },
                              child: Obx(
                                () =>  Container(
                                  margin: EdgeInsets.all(10),
                                  width: 30.w,
                                  alignment: Alignment.center,
                                  child: Text("${getxTextEditingController.months[index]}",style: TextStyle(color: Colors.white),),
                                  decoration: BoxDecoration(
                                    color:getxTextEditingController.indexOfTappedContainer.value == index?Colors.white24:Colors.black,
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(2.h),
                                  ),
                                ),
                              ),
                            );
                          },),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 7.h,
                              width: 40.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.h),
                                border: Border.all(color: Colors.white),
                              ),
                              child: Obx(
                                    () => DropdownButton(
                                      dropdownColor: Colors.black,
                                      items: const [
                                    DropdownMenuItem(
                                      value: 0,
                                      child: Text("Income"),
                                    ),
                                    DropdownMenuItem(
                                      value: 1,
                                      child: Text("Expense"),
                                    ),
                                    DropdownMenuItem(
                                      value: 2,
                                      child: Text("All"),
                                    ),
                                  ],
                                  value: getxTextEditingController.dropDownIncomeExpenseFilter.value,
                                  onChanged: (value) {
                                    getxTextEditingController
                                        .dropDownIncomeExpenseFilter.value = value!;
                                    getxTextEditingController.Filte(
                                      payType: getxTextEditingController.dropDownPayType.value,
                                      statusCode: getxTextEditingController.dropDownIncomeExpenseFilter.value,
                                      toDate: getxTextEditingController.toDate,
                                      month: getxTextEditingController.indexOfTappedContainer.value+1
                                    );
                                  },
                                  style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ),
                            Container(
                              height: 7.h,
                              width: 40.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.h),
                                border: Border.all(color: Colors.white),
                              ),
                              child: Obx(
                                    () => DropdownButton(
                                      dropdownColor: Colors.black,
                                      items:  [
                                    DropdownMenuItem(
                                      value: "online",
                                      child: Text("online"),
                                    ),
                                    DropdownMenuItem(
                                      value: "offline",
                                      child: Text("offline"),
                                    ),
                                    DropdownMenuItem(
                                      value: "all",
                                      child: Text("All"),
                                    ),
                                  ],
                                  value:
                                  getxTextEditingController.dropDownPayType.value,
                                  onChanged: (value) {
                                    getxTextEditingController.dropDownPayType.value = value!;
                                    getxTextEditingController.Filte(
                                      payType: getxTextEditingController
                                          .dropDownPayType.value,
                                      statusCode: getxTextEditingController
                                          .dropDownIncomeExpenseFilter.value,
                                      toDate: getxTextEditingController.toDate,
                                        month: getxTextEditingController.indexOfTappedContainer.value+1

                                    );
                                  },
                                  style: TextStyle(color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 3.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 7.h,
                              width: 40.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.h),
                                border: Border.all(color: Colors.white),
                              ),
                              child: IconButton(
                                onPressed: () async {
                                  DateTime toDate = (await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2023, 1, 1),
                                      builder: (context, child) {
                                        return Theme(data: ThemeData(colorScheme: ColorScheme.light(primary: Color(0xff535272))), child: child!);
                                      },
                                      lastDate: DateTime(2050, 1, 1)))!;
                                  getxTextEditingController.toDate =
                                      "${toDate.day}-${toDate.month}-${toDate.year}";
                                  // getxTextEditingController.DateWiseFilter(todate: getxTextEditingController.toDate);
                                  getxTextEditingController.Filte(
                                    payType: getxTextEditingController
                                        .dropDownPayType.value,
                                    statusCode: getxTextEditingController
                                        .dropDownIncomeExpenseFilter.value,
                                    toDate: getxTextEditingController.toDate,
                                      month: getxTextEditingController.indexOfTappedContainer.value+1
                                  );
                                },
                                icon: const Icon(
                                  Icons.date_range,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  getxTextEditingController.readData();
                                  getxTextEditingController.indexOfTappedContainer.value = 13;
                                  getxTextEditingController.dropDownIncomeExpenseFilter.value = 2;
                                  getxTextEditingController.dropDownPayType.value = "all";
                                  getxTextEditingController.toDate = "";
                                  Get.back();
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xff434273)),
                                child: Text("Reset",style: TextStyle(fontSize: 18),)),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
              icon: Icon(Icons.filter_alt_outlined),
            ),
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: 1.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 7.5.h,
                  width: 20.h,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10.h)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 1.5.w,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 2.w,
                          ),
                          CircleAvatar(
                            radius: 3.h,
                            backgroundColor: Colors.white54,
                            child: Icon(
                              Icons.arrow_downward_outlined,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          Column(
                            children: [
                              Text(
                                "Spending",
                                style: TextStyle(
                                    color: Colors.white54, fontSize: 12),
                              ),
                              Obx(() => getxTextEditingController.isFilterIsApplied == false?Text(
                                    "${getxTextEditingController.sumOfExpense}",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ):Text("${getxTextEditingController.filterExpenseTotal}",style: TextStyle(color: Colors.white,fontSize: 18),)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 12.w,
                ),
                Container(
                  height: 7.5.h,
                  width: 20.h,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10.h)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 1.5.w,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 2.w,
                          ),
                          CircleAvatar(
                            radius: 3.h,
                            backgroundColor: Colors.white54,
                            child: Icon(
                              Icons.arrow_upward_rounded,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          Column(
                            children: [
                              Text(
                                "Income",
                                style: TextStyle(
                                    color: Colors.white54, fontSize: 12),
                              ),
                              Obx(() => getxTextEditingController.isFilterIsApplied == false?Text(
                                "${getxTextEditingController.sumOfIncome}",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ):Text("${getxTextEditingController.filterIncomeTotal}",style: TextStyle(color: Colors.white,fontSize: 18),)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3.h,
            ),
            Container(
              height: 4.h,
              width: 32.w,
              alignment: Alignment.center,
              child: Obx(() => getxTextEditingController.isFilterIsApplied == false?Text(
                    "Balance: ${getxTextEditingController.grandTotal.value}",
                    style: TextStyle(color: Colors.white),
                  ):Text("${getxTextEditingController.filterGrandTotal}",style: TextStyle(color: Colors.white),)),
              decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(20)),
            ),
            SizedBox(
              height: 3.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 2.w,
                ),
                Text(
                  "Details of Transctions",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ],
            ),
            SizedBox(
              height: 1.h,
            ),
            Obx(
              () => Expanded(
                child: Container(
                  height: 50.h,
                  child: ListView.builder(
                    itemCount: getxTextEditingController.datas.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.defaultDialog(
                              title: "Update",
                              content: UpdateAlertDialog(
                                  getxTextEditingController.datas[index]));
                        },
                        onDoubleTap: () {
                          getxTextEditingController.DeleteData(
                              id: getxTextEditingController.datas[index][DataBasedHelper.c_id]);
                          getxTextEditingController.GrandTotal();
                        },
                        child: Container(
                          padding: EdgeInsets.all(15),
                          margin: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 10),
                          height: 12.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                            // color: Colors.white38,
                            border: Border.all(color: Colors.white54),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // SizedBox(width: 1.w,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "${getxTextEditingController.datas[index][DataBasedHelper.c_category]}",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white),
                                      ),
                                      SizedBox(
                                        width: 1.9.w,
                                      ),
                                      Text(
                                        "(${getxTextEditingController.datas[index][DataBasedHelper.c_date]})",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.white60),
                                      ),
                                    ],
                                  ),
                                  // SizedBox(width: 1.w,),
                                  Container(
                                    width: 20.w,
                                    height: 3.h,
                                    alignment: Alignment.center,
                                    child: Text(
                                        "${getxTextEditingController.datas[index][DataBasedHelper.c_payType]}"),
                                    decoration: BoxDecoration(
                                        color: Colors.white54,
                                        borderRadius:
                                            BorderRadius.circular(2.h)),
                                  ),
                                ],
                              ),
                              // Expanded(child: SizedBox()),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  getxTextEditingController.datas[index][
                                              DataBasedHelper
                                                  .c_statusCode] ==
                                          0
                                      ? Icon(
                                          Icons.arrow_upward_rounded,
                                          color: Colors.green,
                                        )
                                      : Icon(
                                          Icons.arrow_downward_outlined,
                                          color: Colors.red.shade300,
                                        ),
                                  Text(
                                    "${getxTextEditingController.datas[index][DataBasedHelper.c_amount]}",
                                    style: TextStyle(
                                        color: getxTextEditingController
                                                        .datas[index][
                                                    DataBasedHelper
                                                        .c_statusCode] ==
                                                0
                                            ? Colors.green
                                            : Colors.red),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 7.h,
            width: 14.w,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
                border: Border.all(color: Colors.white)),
            child: FloatingActionButton(
              backgroundColor: Colors.transparent,
              // focusColor: Colors.white,
              onPressed: () {
                // getxTextEditingController.GrandTotal();
                Get.toNamed("/home");
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}