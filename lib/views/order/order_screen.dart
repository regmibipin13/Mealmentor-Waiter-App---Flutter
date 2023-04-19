import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:meal_mentor/views/order/past_order_screen.dart';
import 'package:meal_mentor/views/order/running_order_screen.dart';

import '../../controller/cart_controller.dart';
import '../../utils/colors.dart';
import '../../utils/image_paths.dart';
import '../cart_screen.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/order_screen';
  OrderScreen({super.key});

  final cart = Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.extraWhiteLight,
        elevation: 5,
        shadowColor: AppColors.shadowColor,
        title: const Image(
          image: AssetImage(
            ImagesPath.logo,
          ),
          height: 80,
        ),
        centerTitle: true,
        actions: [
          Obx(
            () => Stack(
              children: [
                IconButton(
                  onPressed: () {
                    Get.to(() => CartScreen());
                  },
                  icon: const Icon(
                    Icons.shopping_cart_rounded,
                    size: 30,
                    color: Colors.grey,
                  ),
                ),
                if (cart.cartItem.isNotEmpty)
                  Positioned(
                    top: 4,
                    right: 6,
                    child: Container(
                      height: 22,
                      width: 22,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryColor,
                      ),
                      child: Center(
                          child: Text(
                        '${cart.cartItem.length}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              constraints:
                  const BoxConstraints(maxHeight: 150.0, minHeight: 50),
              // ignore: prefer_const_constructors
              child: Material(
                color: AppColors.extraWhiteLight,
                child: const TabBar(
                  indicatorColor: AppColors.primaryColor,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(text: 'Remaining Orders'),
                    Tab(text: 'Past Orders'),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  RunningOrder(),
                  PastOrderScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
