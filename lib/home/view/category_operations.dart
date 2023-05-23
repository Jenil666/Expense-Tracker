import 'package:databased_first_program/utils/data_based_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controller/add_screen_controller.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextFieldController getx = Get.put(TextFieldController());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Category Screen"),
        ),
        body: Obx(
          () =>  ListView.builder(itemCount: getx.category.length,itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              height: 100,
              width: 100,
              child: Row(
                children: [
                  Text("${getx.category[index][DataBasedHelper.c_catCategory]}"),
                  Spacer(),
                  IconButton(onPressed: () {
                    Get.defaultDialog(
                      title: "Update Category",
                      content: Container(
                        height: 20.h,
                        width: 45.w,
                        child:ListView(
                          children: [
                            TextField(
                              controller: getx.txtUpdateCategory,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black45)
                                )
                              ),
                            ),
                            SizedBox(height: 5.h,),
                            Row(
                              children: [
                                ElevatedButton(onPressed: () {
                                  Get.back();
                                },
                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                    child: Text("Cancle"),),
                                ElevatedButton(onPressed: () {
                                  print("----------------------------------------------------------");
                                  print(getx.category[index][DataBasedHelper.c_catCategory]);
                                  // getx.txtUpdateCategory = TextEditingController(text: "${getx.category[index][DataBasedHelper.c_catCategory]}");
                                  getx.UpdateCat(id: getx.category[index][DataBasedHelper.c_catid], category: getx.txtUpdateCategory.text);
                                  getx.AddDataInlistOfEntry();
                                  Get.back();
                                },
                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                                    child: Text("Update")),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }, icon: Icon(Icons.edit,color: Colors.amber,)),
                  IconButton(onPressed: () {
                    getx.DeleteDataInCat(id: getx.category[index][DataBasedHelper.c_catid]);
                    getx.listOfEntry.removeAt(index);
                  }, icon: Icon(Icons.delete,color: Colors.red,)),
                  SizedBox(width: 1.w,),
                ],
              ),
              decoration: BoxDecoration(
                // color: Colors.red,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black45)
              ),
            );
          },),
        ),
      ),
    );
  }
}
