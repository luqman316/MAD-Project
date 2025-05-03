// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalpro/models/product-model.dart';
import 'package:finalpro/screens/user-panel/product-detial-screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';

class AllProductWidget extends StatelessWidget {
  const AllProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('products')
          .where('isSale', isEqualTo: false)
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
            child: Text('No products found'),
          );
        }
        if (snapshot.data != null) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 0.80,
            ),
            itemCount: snapshot.data!.docs.length,
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var productData = snapshot.data!.docs[index];
              ProductModel productModel = ProductModel(
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
              );
              // CategoriesModel categoriesModel = CategoriesModel(
              //   categoryId: doc['categoryId'] ?? '',
              //   categoryImg: doc['categoryImg'] ?? '',
              //   categoryName: doc['categoryName'] ?? '',
              //   updatedAt: doc['updatedAt'],
              //   createdAt: doc['createdAt'],
              // );
              return Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.to(() => ProductDetailScreen(
                          productModel: productModel,
                        )),
                    child: Padding(
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
                              maxLines: 1,
                              style: TextStyle(fontSize: 12.0),
                            ),
                          ),
                          footer: Text("PKR: " + productModel.fullPrice),
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          );
        }
        return Container();
      },
    );
  }
}
