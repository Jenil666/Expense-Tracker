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
                  context: context,
                  builder: (context) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 3.h,
                        ),
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
                        SizedBox(
                          height: 3.h,
                        ),
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
                        SizedBox(
                          height: 3.h,
                        ),
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
                              Obx(() => Text(
                                    "${getxTextEditingController.sumOfExpense}",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  )),
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
                              Obx(() => Text(
                                    "${getxTextEditingController.sumOfIncome}",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  )),
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
              child: Obx(() => Text(
                    "Balance: ${getxTextEditingController.grandTotal.value}",
                    style: TextStyle(color: Colors.white),
                  )),
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
                              content: UpdateAlertDialog(
                                  getxTextEditingController.datas[index]));
                        },
                        child: Container(
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
                            children: [
                              SizedBox(
                                width: 3.w,
                              ),
                              Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                  SizedBox(
                                    width: 40.w,
                                  ),
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
          child: Container(decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white)
          ),
            child: FloatingActionButton(
              backgroundColor: Colors.transparent,
              // focusColor: Colors.white,
              onPressed: () {
                // getxTextEditingController.GrandTotal();
                Get.toNamed("/home");
              },
              child: Icon(Icons.add,color: Colors.white,),
            ),
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

/*
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
                                  getxTextEditingController.DeleteData(
                                      id: getxTextEditingController.datas[index]
                                          [DataBasedHelper.c_id]);
                                  getxTextEditingController.GrandTotal();
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
 */
