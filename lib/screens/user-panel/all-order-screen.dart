// ignore_for_file: unused_import

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalpro/controllers/cart-price-controller.dart';
import 'package:finalpro/models/cart-model.dart';
import 'package:finalpro/models/order-model.dart';
import 'package:finalpro/screens/user-panel/checkout-screen.dart';
import 'package:finalpro/utils/app-constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:image_card/image_card.dart';

class AllOrderScreen extends StatefulWidget {
  const AllOrderScreen({super.key});

  @override
  State<AllOrderScreen> createState() => _AllOrderScreenState();
}

class _AllOrderScreenState extends State<AllOrderScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final ProductPriceController productPriceController =
      Get.put(ProductPriceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text('All Orders',
            style: TextStyle(
              color: AppConstant.appTextColor,
            )),
        centerTitle: true,
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .doc(user!.uid)
            .collection('confirmOrders')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              height: Get.height / 5,
              child: Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }
          if (!snapshot.hasData ||
              snapshot.data == null ||
              snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No products found'),
            );
          }
          if (snapshot.data != null) {
            return Container(
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  var productData = snapshot.data!.docs[index];
                  OrderModel orderModel = OrderModel(
                    productId: productData['productId'],
                    categoryId: productData['categoryId'],
                    productName: productData['productName'],
                    categoryName: productData['categoryName'],
                    salePrice: productData['salePrice'],
                    fullPrice: productData['fullPrice'],
                    productImages: productData['productImages'],
                    deliveryTime: productData['deliveryTime'],
                    isSale: productData['isSale'],
                    productDescription: productData['productDescription'],
                    createdAt: productData['createdAt'],
                    updatedAt: productData['updatedAt'],
                    productQuantity: productData['productQuantity'],
                    productTotalPrice: productData['productTotalPrice'],
                    customerId: productData['customerId'],
                    status: productData['status'],
                    customerName: productData['customerName'],
                    customerPhone: productData['customerPhone'],
                    customerAddress: productData['customerAddress'],
                    customerDeviceToken: productData['customerDeviceToken'],
                  );
                  productPriceController.fetchProductPrice();
                  return Card(
                    elevation: 5,
                    color: AppConstant.appTextColor,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: AppConstant.appMainColor,
                        backgroundImage:
                            NetworkImage(orderModel.productImages[0]),
                        // child: Text('N'),
                      ),
                      title: Text(orderModel.productName),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(orderModel.productTotalPrice.toString()),
                          SizedBox(
                            width: 10.0,
                          ),
                          orderModel.status != true
                              ? Text(
                                  "Pending..",
                                  style: TextStyle(color: Colors.green),
                                )
                              : Text(
                                  "Deliverd",
                                  style: TextStyle(color: Colors.red),
                                )
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
