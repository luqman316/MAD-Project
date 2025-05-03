// ignore_for_file: must_be_immutable, prefer_interpolation_to_compose_strings, unused_local_variable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalpro/models/cart-model.dart';
import 'package:finalpro/models/product-model.dart';
import 'package:finalpro/utils/app-constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailScreen extends StatefulWidget {
  ProductModel productModel;
  ProductDetailScreen({super.key, required this.productModel});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        backgroundColor: AppConstant.appMainColor,
        title: Text(
          'Product Details',
          style: TextStyle(
            color: AppConstant.appTextColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: Get.height / 60,
            ),
            //Product Image
            CarouselSlider(
              items: widget.productModel.productImages
                  .map(
                    (imageUrls) => ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: CachedNetworkImage(
                        imageUrl: imageUrls,
                        fit: BoxFit.cover,
                        width: Get.width - 10,
                        placeholder: (context, url) => ColoredBox(
                          color: Colors.white,
                          child: Center(
                            child: CupertinoActivityIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                scrollDirection: Axis.horizontal,
                autoPlay: true,
                aspectRatio: 2.5,
                viewportFraction: 1,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.productModel.productName,
                            ),
                            Icon(Icons.favorite_outline)
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            widget.productModel.isSale == true &&
                                    widget.productModel.salePrice != ""
                                ? Text(
                                    "PKR: " + widget.productModel.salePrice,
                                  )
                                : Text(
                                    "PKR: " + widget.productModel.fullPrice,
                                  ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          widget.productModel.categoryName,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          widget.productModel.productDescription,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Material(
                            child: Container(
                              width: Get.width / 3.0,
                              height: Get.height / 16,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: AppConstant.appSecondaryColor,
                              ),
                              child: TextButton(
                                  child: Text(
                                    "Whatsapp",
                                    style: TextStyle(
                                        color: AppConstant.appTextColor),
                                  ),
                                  onPressed: () {
                                    // Get.to(() => SignInScreen());
                                  }),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Material(
                            child: Container(
                              width: Get.width / 3.0,
                              height: Get.height / 16,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: AppConstant.appSecondaryColor,
                              ),
                              child: TextButton(
                                  child: Text(
                                    "Add to Cart",
                                    style: TextStyle(
                                        color: AppConstant.appTextColor),
                                  ),
                                  onPressed: () async {
                                    // Get.to(() => SignInScreen());
                                    await CheckProductExistence(uId: user!.uid);
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Check if the product already exists in the cart
  // If it does, show a message or update the quantity
  // If it doesn't, add it to the cart
  Future<void> CheckProductExistence({
    required String uId,
    int quantityIncrement = 1,
  }) async {
    final DocumentReference documentReference = FirebaseFirestore.instance
        .collection('cart')
        .doc(uId)
        .collection('cartOrders')
        .doc(widget.productModel.productId.toString());

    DocumentSnapshot snapshot = await documentReference.get();

    if (snapshot.exists) {
      int currentQuantity =
          snapshot['productQuantity']; // Get the current quantity
      int updatedQuantity = currentQuantity + quantityIncrement;
      double totalPrice = updatedQuantity *
          double.parse(widget.productModel.salePrice != ""
              ? widget.productModel.salePrice
              : widget.productModel.fullPrice);
      await documentReference.update({
        "productQuantity": updatedQuantity,
        "productTotalPrice": totalPrice,
      });
      print ("Product exists in  cart");
    } else {
      await FirebaseFirestore.instance.collection('cart').doc(uId).set({
        "uId": uId,
        "createdAt": DateTime.now(),
      });
      CartModel cartModel = CartModel(
        productId: widget.productModel.productId,
        categoryId: widget.productModel.categoryId,
        productName: widget.productModel.productName,
        categoryName: widget.productModel.categoryName,
        salePrice: widget.productModel.salePrice,
        fullPrice: widget.productModel.fullPrice,
        productImages: widget.productModel.productImages,
        deliveryTime: widget.productModel.deliveryTime,
        isSale: widget.productModel.isSale,
        productDescription: widget.productModel.productDescription,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        productQuantity: quantityIncrement,
        productTotalPrice:
            double.parse(widget.productModel.salePrice != ""
                ? widget.productModel.salePrice
                : widget.productModel.fullPrice),
      );
      await documentReference.set(cartModel.toMap());
      print ("Product added to cart");
    }
  }
}
