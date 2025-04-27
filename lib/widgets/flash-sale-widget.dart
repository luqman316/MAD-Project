import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalpro/models/product-model.dart';
import 'package:finalpro/utils/app-constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';

class FlashSaleWidget extends StatelessWidget {
  const FlashSaleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('products')
          .where('isSale', isEqualTo: true)
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
          return Container(
            height: Get.height / 4.5,
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final productData = snapshot.data!.docs[index];
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
                var fillImageCard = FillImageCard(
                  heightImage: Get.height / 12,
                  width: Get.width / 3.5,
                  borderRadius: 20.0,
                  imageProvider: CachedNetworkImageProvider(
                    productModel.productImages[0],
                  ),
                  title: Center(
                    child: Text(
                      productModel.productName,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 10.0),
                    ),
                  ),
                  footer: Row(
                    children: [
                      Text(
                        "Rs. ${productModel.salePrice}",
                        style: TextStyle(fontSize: 10.0),
                      ),
                      SizedBox(
                        width: 2.0,
                      ),
                      Text(
                        " ${productModel.fullPrice}",
                        style: TextStyle(
                          fontSize: 10.0,
                          decoration: TextDecoration.lineThrough,
                          color: AppConstant.appSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                );
                return Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Container(
                        child: fillImageCard,
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        }

        return Container();
      },
    );
  }
}
