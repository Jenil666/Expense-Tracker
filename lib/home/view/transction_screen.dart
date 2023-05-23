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
    print("================================================");
    getxTextEditingController.GrandTotal();
    // getxTextEditingController.MethodCallToGetValue();
  }

  @override
  Widget build(BuildContext context) {
    print("================================================");
    getxTextEditingController.GrandTotal();
    getxTextEditingController.readData();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Khata Book"),
          actions: [
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 3.h,),
                        Container(
                          height: 10.h,
                          width: 80.w,
                          alignment: Alignment.center,
                          child: Obx(
                            () => DropdownButton(
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
                              value: getxTextEditingController
                                  .dropDownIncomeExpenseFilter.value,
                              onChanged: (value) {
                                print(getxTextEditingController.updated);
                                getxTextEditingController
                                    .dropDownIncomeExpenseFilter.value = value!;
                                getxTextEditingController.Filte(
                                  payType: getxTextEditingController
                                      .dropDownPayType.value,
                                  statusCode: getxTextEditingController
                                      .dropDownIncomeExpenseFilter.value,
                                  toDate: getxTextEditingController.toDate,
                                );
                                // setState(() {});
                              },
                            ),
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black45)),
                        ),
                        SizedBox(height: 3.h,),
                        Container(
                          height: 10.h,
                          width: 80.w,
                          alignment: Alignment.center,
                          child: Obx(
                            () => DropdownButton(
                              items: const [
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
                                  child: Text("all"),
                                ),
                              ],
                              value: getxTextEditingController
                                  .dropDownPayType.value,
                              onChanged: (value) {
                                print(getxTextEditingController.updated);
                                getxTextEditingController
                                    .dropDownPayType.value = value!;
                                getxTextEditingController.Filte(
                                  payType: getxTextEditingController
                                      .dropDownPayType.value,
                                  statusCode: getxTextEditingController
                                      .dropDownIncomeExpenseFilter.value,
                                  toDate: getxTextEditingController.toDate,
                                );
                              },
                            ),
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black45)),
                        ),
                        SizedBox(height: 3.h,),
                        IconButton(
                          onPressed: () async {
                            DateTime toDate = (await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2023, 1, 1),
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
                            );
                          },
                          icon: const Icon(Icons.date_range),
                        ),
                        Spacer(),
                        ElevatedButton(
                            onPressed: () {
                              getxTextEditingController.readData();
                              Get.back();
                            },
                            child: Text("Reset")),
                        SizedBox(
                          height: 3.h,
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
        body: Obx(
          () =>  Column(
            children: [
              SizedBox(
                height: 1.h,
              ),
              Container(
                height: 20.h,
                width: 96.w,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Total"),
                    Obx(() => Text("${getxTextEditingController.grandTotal.value}",
                          style: TextStyle(fontSize: 20),
                        )),
                  ],
                ),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black45)),
              ),
              Container(
                margin: EdgeInsets.all(1.h),
                height: 12.h,
                width: 100.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 4.h,
                          width: 20.w,
                          alignment: Alignment.center,
                          child: Text("Income"),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.black38)),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.arrow_upward_rounded,
                              color: Colors.green,
                            ),
                            Text(
                              "${getxTextEditingController.sumOfIncome}",
                              style: TextStyle(color: Colors.green),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 4.h,
                          width: 20.w,
                          alignment: Alignment.center,
                          child: Text("Income"),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.black38)),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.arrow_downward_outlined,
                              color: Colors.redAccent,
                            ),
                            Text(
                              "${getxTextEditingController.sumOfExpense}",
                              style: TextStyle(color: Colors.redAccent),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 3,
                        offset: Offset(0, 2),
                      ),
                    ]),
              ),
              Text(
                "Details of Transctions",
                style: TextStyle(fontSize: 20),
              ),
              Obx(
                () => Expanded(
                  child: Container(
                    height: 50.h,
                    // color: Colors.blue.shade50,
                    child: ListView.builder(
                      itemCount: getxTextEditingController.datas.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.all(10),
                          height: 12.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black38,
                                    blurRadius: 0.5,
                                    spreadRadius: 0.5)
                              ]),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 3.w,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${getxTextEditingController.datas[index][DataBasedHelper.c_category]}",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Text(
                                        "(${getxTextEditingController.datas[index][DataBasedHelper.c_date]})",
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.black38),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      getxTextEditingController.datas[index][
                                                  DataBasedHelper.c_statusCode] ==
                                              0
                                          ? Icon(
                                              Icons.arrow_upward_rounded,
                                              color: Colors.green,
                                            )
                                          : Icon(
                                              Icons.arrow_upward_rounded,
                                              color: Colors.redAccent,
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
                              Spacer(),
                              IconButton(
                                onPressed: () {
                                  Get.defaultDialog(
                                      content: UpdateAlertDialog(
                                          getxTextEditingController.datas[index]));
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.green,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  getxTextEditingController.GrandTotal();
                                  getxTextEditingController.DeleteData(
                                      id: getxTextEditingController.datas[index]
                                          [DataBasedHelper.c_id]);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Align(
          alignment: Alignment.bottomCenter,
          child: FloatingActionButton(
            onPressed: () {
              // getxTextEditingController.TotalExpense();
              // getxTextEditingController.TotalIncome();
              // getxTextEditingController.GrandTotal()
              print("jenilcghcghcchgcycghfthrthfbn vnnnnnnnnnnnnnn");
              Get.toNamed("/home");
            },
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

// child: ListTile(
//   title: Text("${getxTextEditingController.datas[index][DataBasedHelper.c_category]}"),
//   trailing: Row(
//     mainAxisSize: MainAxisSize.min,
//     children: [
//       IconButton(
//         onPressed: () {
//           Get.defaultDialog(
//               content: UpdateAlertDialog(
//                   getxTextEditingController
//                       .datas[index]));
//         },
//         icon: const Icon(
//           Icons.edit,
//           color: Colors.green,
//         ),
//       ),
//       IconButton(
//         onPressed: () {
//           getxTextEditingController.DeleteData(
//               id: getxTextEditingController.datas[index]
//                   [DataBasedHelper.c_id]);
//         },
//         icon: const Icon(
//           Icons.delete,
//           color: Colors.red,
//         ),
//       ),
//     ],
//   ),
// ),
