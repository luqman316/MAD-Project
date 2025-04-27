// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalpro/models/product-model.dart';
import 'package:finalpro/utils/app-constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';

class SingleCategoriesScree extends StatefulWidget {
  String categoryId;
  SingleCategoriesScree({super.key, required this.categoryId});

  @override
  State<SingleCategoriesScree> createState() => _SingleCategoriesScreeState();
}

class _SingleCategoriesScreeState extends State<SingleCategoriesScree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appSecondaryColor,
        title: Text(
          'Products',
          style: TextStyle(color: AppConstant.appTextColor),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('products')
            .where('categoryId', isEqualTo: widget.categoryId)
            .get(),
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
              child: Text('No categories available'),
            );
          }
          if (snapshot.data != null) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 3,
                  childAspectRatio: 1.19),
              itemCount: snapshot.data!.docs.length,
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final producyData = snapshot.data!.docs[index];
                ProductModel productModel = ProductModel(
                  productId: producyData['productId'],
                  categoryId: producyData['categoryId'],
                  productName: producyData['productName'],
                  categoryName: producyData['categoryName'],
                  salePrice: producyData['salePrice'],
                  fullPrice: producyData['fullPrice'],
                  productImages: producyData['productImages'],
                  deliveryTime: producyData['deliveryTime'],
                  isSale: producyData['isSale'],
                  productDescription: producyData['productDescription'],
                  createdAt: producyData['createdAt'],
                  updatedAt: producyData['updatedAt'],
                );
                return Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        child: FillImageCard(
                          heightImage: Get.height / 10,
                          width: Get.width / 2.3,
                          borderRadius: 20.0,
                          imageProvider: CachedNetworkImageProvider(
                            productModel.productImages[0],
                            // categoriesModel.categoryName,
                          ),
                          title: Center(
                            child: Text(
                              productModel.productName,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 12.0),
                            ),
                          ),
                          // footer: Text(''),
                        ),
                      ),
                    )
                  ],
                );
              },
            );
            // Container(
            //   height: Get.height / 5.5,
            //   child: ListView.builder(
            //     itemCount: snapshot.data!.docs.length,
            //     scrollDirection: Axis.horizontal,
            //     shrinkWrap: true,
            //   ),
            // );
          }

          return Container();
        },
      ),
    );
  }
}
