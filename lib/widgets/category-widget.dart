import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalpro/models/categories-model.dart';
import 'package:finalpro/screens/user-panel/single-categories-screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('categories').get(),
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
          return Container(
            height: Get.height / 5.5,
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var doc = snapshot.data!.docs[index];
                CategoriesModel categoriesModel = CategoriesModel(
                  categoryId: doc['categoryId'] ?? '',
                  categoryImg: doc['categoryImg'] ?? '',
                  categoryName: doc['categoryName'] ?? '',
                  updatedAt: doc['updatedAt'],
                  createdAt: doc['createdAt'],
                );
                return Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.to(
                        () => SingleCategoriesScree(
                            categoryId: categoriesModel.categoryId),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Container(
                          child: FillImageCard(
                            heightImage: Get.height / 12,
                            width: Get.width / 4.0,
                            borderRadius: 20.0,
                            imageProvider: CachedNetworkImageProvider(
                              categoriesModel.categoryImg,
                              // categoriesModel.categoryName,
                            ),
                            title: Center(
                              child: Text(
                                categoriesModel.categoryName,
                                style: TextStyle(fontSize: 12.0),
                              ),
                            ),
                            // footer: Text(''),
                          ),
                        ),
                      ),
                    )
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
