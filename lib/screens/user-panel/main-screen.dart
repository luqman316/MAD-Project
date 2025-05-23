// ignore_for_file: file_names

import 'package:finalpro/screens/user-panel/all-categories-screen.dart';
import 'package:finalpro/screens/user-panel/all-flash-sale-product.dart';
import 'package:finalpro/screens/user-panel/all-product-screen.dart';
import 'package:finalpro/screens/user-panel/cart-screen.dart';
import 'package:finalpro/utils/app-constant.dart';
import 'package:finalpro/widgets/all-product-widget.dart';
import 'package:finalpro/widgets/banner-widget.dart';
import 'package:finalpro/widgets/category-widget.dart';
import 'package:finalpro/widgets/custom-drawer-widget.dart';
import 'package:finalpro/widgets/flash-sale-widget.dart';
import 'package:finalpro/widgets/heading-widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:flutter/material.dart.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppConstant.appTextColor,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppConstant.appSecondaryColor,
            statusBarIconBrightness: Brightness.light),
        backgroundColor: AppConstant.appSecondaryColor,
        title: Text(
          AppConstant.appMainName,
          style: TextStyle(color: AppConstant.appTextColor),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () => Get.to(() => CartScreen()),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.shopping_cart),
            ),
          ),
        ],
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
      ),
      drawer: DrawerWidget(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: Get.height / 90.0,
              ),
              // Text('luqi'),
              //BannerWidget
              BannerWidget(),

              // HeadingWidget(),
              HeadingWidget(
                headingTitle: 'Categories',
                headingSubtitle: 'According to your choice',
                onTap: () => Get.to(AllCategoriesScree()),
                buttonText: 'see more >',
              ),
              // CategoriesWidget(),
              CategoriesWidget(),

              HeadingWidget(
                headingTitle: 'Flash Sale',
                headingSubtitle: 'According to your choice',
                onTap: () => Get.to(AllFlashSaleProduct()),
                buttonText: 'see more >',
              ),
              FlashSaleWidget(),

              // HeadingWidget(),
              HeadingWidget(
                headingTitle: 'All Products',
                headingSubtitle: 'According to your choice',
                onTap: () => Get.to(AllProductScreen()),
                buttonText: 'see more >',
              ),
              AllProductWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
