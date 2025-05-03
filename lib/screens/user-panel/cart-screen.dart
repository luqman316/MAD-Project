import 'package:finalpro/utils/app-constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text('Cart',
            style: TextStyle(
              color: AppConstant.appTextColor,
            )),
        centerTitle: true,
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: 20,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              color: AppConstant.appTextColor,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppConstant.appMainColor,
                  child: Text('N'),
                ),
                title: Text('Product '),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("2200"),
                    SizedBox(
                      width: 10,
                    ),
                    CircleAvatar(
                      radius: 14,
                      backgroundColor: AppConstant.appMainColor,
                      child: Text("+"),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    CircleAvatar(
                      radius: 14,
                      backgroundColor: AppConstant.appMainColor,
                      child: Text("-"),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Total:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                )),
            // SizedBox(
            //   width: 10,
            // ),
            Text('12000',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                child: Container(
                  width: Get.width / 2.0,
                  height: Get.height / 18,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: AppConstant.appSecondaryColor,
                  ),
                  child: TextButton(
                      child: Text(
                        "checkout",
                        style: TextStyle(color: AppConstant.appTextColor),
                      ),
                      onPressed: () {}),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
