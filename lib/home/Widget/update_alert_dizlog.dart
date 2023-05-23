import 'package:databased_first_program/home/controller/add_screen_controller.dart';
import 'package:databased_first_program/utils/data_based_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class UpdateAlertDialog extends StatelessWidget {
  TextFieldController getxTextEditingController = Get.find();
  UpdateAlertDialog(this.data);

  Map? data;

  @override
  Widget build(BuildContext context) {
    getxTextEditingController.dropDownValueForayType.value = data![DataBasedHelper.c_payType];
    getxTextEditingController.dropDownValueForIncomeExpense.value = data![DataBasedHelper.c_statusCode];
    getxTextEditingController.dropDownValueFoDate.value = data![DataBasedHelper.c_date];
    return  Obx(
      () =>
          Container(
          height: 275,
          width: 500,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    txtField(txtController: getxTextEditingController.updatedtxtAmount, txtHintText: 'Amount'),
                    DropdownMenu(
                      hintText: "${data![DataBasedHelper.c_catCategory]}",
                        onSelected: (value)  {
                          getxTextEditingController.txtCategary.text = value!;
                        },
                        dropdownMenuEntries: getxTextEditingController.listOfEntry),
                    SizedBox(height:0.7.h),
                    Container(
                      padding: EdgeInsets.all(2.w),
                      height: 10.h,
                      width: 100.w,
                      child: Row(
                        children: [
                          Text("${getxTextEditingController.dropDownValueFoDate}"),
                          Spacer(),
                          IconButton(onPressed: () async {
                            DateTime? date = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2001,1,1), lastDate: DateTime(2050,1,1));
                            getxTextEditingController.date.value = "${date?.day}-${date?.month}-${date?.year}";
                            getxTextEditingController.dropDownValueFoDate.value = "${date?.day}-${date?.month}-${date?.year}";
                            if(getxTextEditingController.date.value == "null-null-null")
                              {
                                getxTextEditingController.date.value = data![DataBasedHelper.c_date];
                                getxTextEditingController.dropDownValueFoDate.value = data![DataBasedHelper.c_date];
                              }
                          }, icon: Icon(Icons.calendar_month_outlined),),
                        ],
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45),
                      ),
                    ),
                    txtField(txtController: getxTextEditingController.updatedtxtTime, txtHintText: 'Time'),
                     Container(
                       padding: EdgeInsets.all(3.w),
                       height: 8.h,
                       width: 5.w,
                       alignment: Alignment.centerLeft,
                       child: DropdownButton(
                         style: TextStyle(fontSize: 20,color: Colors.black),
                            items: const [
                              DropdownMenuItem(
                                value: "online",
                                child: Text("online"),
                              ),
                              DropdownMenuItem(
                                value: "offline",
                                child: Text("offline"),
                              ),
                            ],
                            value: getxTextEditingController.dropDownValueForayType.value,
                            onChanged: (value) {
                              getxTextEditingController.dropDownValueForayType.value = value!;
                              getxTextEditingController.dropDownPayType.value = value as String;
                            },
                          ),
                       decoration: BoxDecoration(
                         border: Border.all(color: Colors.black45),
                         borderRadius: BorderRadius.circular(5)
                       ),
                     ),
                    SizedBox(height:0.7.h),
                    Container(
                      padding: EdgeInsets.all(3.w),
                      height: 8.h,
                      width: 5.w,
                      alignment: Alignment.centerLeft,
                      child: Obx(
                        () =>
                            DropdownButton(
                              style: TextStyle(fontSize: 20,color: Colors.black),
                              items: const [
                            DropdownMenuItem(
                              value: 0,
                              child: Text("Income"),
                            ),
                            DropdownMenuItem(
                              value: 1,
                              child: Text("Expense"),
                            ),
                          ],
                          value: getxTextEditingController.dropDownValueForIncomeExpense.value,
                          onChanged: (value) {
                            print(value);
                            getxTextEditingController.dropDownValueForIncomeExpense.value = value!;
                            getxTextEditingController.dropDownIncomeExpenseFilter.value = value;
                          },
                        ),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black45),
                          borderRadius: BorderRadius.circular(5)
                      ),

                    ),
                    SizedBox(height:0.7.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: Color(0xff434273)),
                          child: Text("Cancle"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                              getxTextEditingController.DeleteData(
                                  id: data![DataBasedHelper.c_id]);
                              getxTextEditingController.GrandTotal();
                              Get.back();
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                          child: Text("Delete"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if(getxTextEditingController.txtCategary.text != "") {
                              int statusCode = getxTextEditingController
                                  .dropDownIncomeExpenseFilter.value;
                              String payType = getxTextEditingController
                                  .dropDownPayType.value;
                              String notes = getxTextEditingController.updatedtxtNote
                                  .text;
                              String time = getxTextEditingController.updatedtxtTime
                                  .text;
                              String date = getxTextEditingController.date.value;
                              String category = getxTextEditingController.txtCategary
                                  .text;
                              String amount = getxTextEditingController
                                  .updatedtxtAmount.text;
                              getxTextEditingController.Update(statusCode: statusCode,
                                  notes: notes,
                                  time: time,
                                  date: date,
                                  category: category,
                                  amount: amount,
                                  id: "${data![DataBasedHelper.c_id]}",
                                  payTypes: payType);
                              getxTextEditingController.GrandTotal();
                              Get.back();
                            }
                            else
                              {
                                Get.snackbar("Khata Book App", "Select Category");
                              }
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: Color(0xff434273)),
                          child: Text("Update"),
                        ),
                      ],
                      /*

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
                       */
                    ),
                  ],
                ),
              ),
            ],
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
