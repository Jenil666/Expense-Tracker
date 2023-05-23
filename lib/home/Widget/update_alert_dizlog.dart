import 'package:databased_first_program/home/controller/add_screen_controller.dart';
import 'package:databased_first_program/utils/data_based_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class UpdateAlertDialog extends StatelessWidget {
  TextFieldController getxTextEditingController = Get.find();
  UpdateAlertDialog(this.data)
  {
  getxTextEditingController.updatedtxtAmount = TextEditingController(text: "${data!['${DataBasedHelper.c_amount}']}");
  getxTextEditingController.updatedtxtCategary = TextEditingController(text: "${data!['${DataBasedHelper.c_category}']}");// change  okk
  getxTextEditingController.updatedtxtDate = TextEditingController(text: "${data!['${DataBasedHelper.c_date}']}");// change  okk
  getxTextEditingController.updatedtxtTime = TextEditingController(text: "${data!['${DataBasedHelper.c_time}']}");// change!!!!!
  getxTextEditingController.updatedtxtNote = TextEditingController(text: "${data!['${DataBasedHelper.c_notes}']}");
  getxTextEditingController.updatedtxtStatusCode = TextEditingController(text: "${data!['${DataBasedHelper.c_statusCode}']}");//change okk
  getxTextEditingController.updatedtxtPayType = TextEditingController(text: "${data!['${DataBasedHelper.c_payType}']}");//change okk
}

  Map? data;
  // UpdateAlertDialog({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 275,
      width: 500,
      child: ListView(
        shrinkWrap: true,
        children: [
          txtField(txtController: getxTextEditingController.updatedtxtAmount, txtHintText: 'Amount'),
          // txtField(txtController: getxTextEditingController.updatedtxtCategary, txtHintText: 'Category'),
          DropdownMenu(
            hintText: "${data![DataBasedHelper.c_catCategory]}",
              onSelected: (value)  {
                getxTextEditingController.txtCategary.text = value!;
              },
              // label: getxTextEditingController.listOfEntry.isEmpty ? Text("Add Items") : Text("Seletc Items",style: TextStyle(fontSize: 12),),
              dropdownMenuEntries: getxTextEditingController.listOfEntry),
          SizedBox(height:0.7.h),
          // txtField(txtController: getxTextEditingController.updatedtxtDate, txtHintText: 'Date'),
          Container(
            padding: EdgeInsets.all(2.w),
            height: 10.h,
            width: 100.w,
            child: Row(
              children: [
                Text("${data![DataBasedHelper.c_date]}"),
                Spacer(),
                IconButton(onPressed: () async {
                  DateTime? date = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2001,1,1), lastDate: DateTime(2050,1,1));
                  getxTextEditingController.date.value = "${date?.day}-${date?.month}-${date?.year}";
                }, icon: Icon(Icons.calendar_month_outlined),),
              ],
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black45),
            ),
          ),
          txtField(txtController: getxTextEditingController.updatedtxtTime, txtHintText: 'Time'),

          Obx(
            () =>  DropdownButton(
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
              value: getxTextEditingController.dropDownPayType.value,
              onChanged: (value) {
                print(getxTextEditingController.updated);
                print(value);
                getxTextEditingController.dropDownPayType.value = value!;
                print("done");
                print(getxTextEditingController.dropDownPayType.value);
              },
            ),
          ),

          Obx(
            () =>  DropdownButton(
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
              value: getxTextEditingController.dropDownIncomeExpenseFilter.value,
              onChanged: (value) {
                print(getxTextEditingController.updated);
                getxTextEditingController.dropDownIncomeExpenseFilter.value = value!;
              },
            ),
          ),




          // txtField(txtController: getxTextEditingController.updatedtxtNote, txtHintText: 'Note'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // print("====================================================");
                  // print("${getxTextEditingController.date}");
                  Get.back();
                },
                child: Text("Cancle"),
              ),
              ElevatedButton(
                onPressed: () {
                  print("====================================================");
                  // print("${getxTextEditingController.date.value}");
                  int statusCode= getxTextEditingController.dropDownIncomeExpenseFilter.value ;
                  String payType = getxTextEditingController.dropDownPayType.value;
                  String notes= getxTextEditingController.updatedtxtNote.text;
                  String time= getxTextEditingController.updatedtxtTime.text;
                  String date= getxTextEditingController.date.value;
                  print("end");
                  print(payType);
                  String category= getxTextEditingController.txtCategary.text;
                  String amount= getxTextEditingController.updatedtxtAmount.text;
                  getxTextEditingController.Update(statusCode: statusCode, notes: notes, time: time, date: date, category: category, amount: amount, id: "${data![DataBasedHelper.c_id]}",payTypes: payType);
                  getxTextEditingController.GrandTotal();
                  Get.back();
                },
                child: Text("Update"),
              ),
            ],
          ),
        ],
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
