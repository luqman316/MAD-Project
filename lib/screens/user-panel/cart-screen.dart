// ignore_for_file: unused_import

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalpro/controllers/cart-price-controller.dart';
import 'package:finalpro/models/cart-model.dart';
import 'package:finalpro/screens/user-panel/checkout-screen.dart';
import 'package:finalpro/utils/app-constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:image_card/image_card.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final ProductPriceController productPriceController =
      Get.put(ProductPriceController());

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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('cart')
            .doc(user!.uid)
            .collection('cartOrders')
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
                  CartModel cartModel = CartModel(
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
                  );
                  productPriceController.fetchProductPrice();
                  return SwipeActionCell(
                    key: ObjectKey(cartModel.productId),
                    trailingActions: [
                      SwipeAction(
                          title: "Delete",
                          forceAlignmentToBoundary: true,
                          performsFirstActionWithFullSwipe: true,
                          onTap: ((CompletionHandler handler) async {
                            print('Deleted');
                            await FirebaseFirestore.instance
                                .collection('cart')
                                .doc(user!.uid)
                                .collection('cartOrders')
                                .doc(cartModel.productId)
                                .delete();
                          }))
                    ],
                    child: Card(
                      elevation: 5,
                      color: AppConstant.appTextColor,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppConstant.appMainColor,
                          backgroundImage:
                              NetworkImage(cartModel.productImages[0]),
                          // child: Text('N'),
                        ),
                        title: Text(cartModel.productName),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(cartModel.productTotalPrice.toString()),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (cartModel.productQuantity > 1) {
                                  FirebaseFirestore.instance
                                      .collection('cart')
                                      .doc(user!.uid)
                                      .collection('cartOrders')
                                      .doc(cartModel.productId)
                                      .update({
                                    'productQuantity':
                                        cartModel.productQuantity - 1,
                                    'productTotalPrice':
                                        (double.parse(cartModel.fullPrice) *
                                            (cartModel.productQuantity - 1)),
                                  });
                                }
                              },
                              child: CircleAvatar(
                                radius: 14,
                                backgroundColor: Colors.blueGrey.shade100,
                                child: Text("-"),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (cartModel.productQuantity > 0) {
                                  await FirebaseFirestore.instance
                                      .collection('cart')
                                      .doc(user!.uid)
                                      .collection('cartOrders')
                                      .doc(cartModel.productId)
                                      .update({
                                    'productQuantity':
                                        cartModel.productQuantity + 1,
                                    'productTotalPrice':
                                        double.parse(cartModel.fullPrice) +
                                            double.parse(cartModel.fullPrice) *
                                                (cartModel.productQuantity)
                                  });
                                }
                              },
                              child: CircleAvatar(
                                radius: 14.0,
                                backgroundColor: Colors.blueGrey.shade100,
                                child: Text('+'),
                              ),
                            )
                          ],
                        ),
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
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(
              () => Text(
                " Total ${productPriceController.totalPrice.value.toStringAsFixed(1)} : PKR",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
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
                    onPressed: () {
                      Get.to(() => CheckOutScreen());
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
