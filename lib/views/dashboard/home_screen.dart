import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_mentor/controller/cart_controller.dart';
import 'package:meal_mentor/models/meal_mentor_category.dart';
import 'package:meal_mentor/models/meal_mentor_item.dart';
import 'package:meal_mentor/utils/colors.dart';
import 'package:meal_mentor/views/cart_screen.dart';

import '../../controller/home_screen_controller.dart';
import '../../utils/image_paths.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home_screen';
  HomeScreen({super.key});

  final c = Get.find<HomeController>();
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
          width: 100,
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
      body: Obx(
        () => (c.loading.value)
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: () async {
                  c.getAllCategory();
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 23),
                      child: Text(
                        "Category",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(
                      () => SizedBox(
                        height: 51,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: c.itemCategory.length + 1,
                          itemBuilder: (context, index) {
                            final colors = [
                              const Color(0xffFBF5EB),
                              const Color(0xFFF4F8FC),
                              const Color(0xffFDEEF4),
                              const Color(0xffF7F7F5),
                            ];
                            final colorIndex = index % colors.length;
                            if (index == 0) {
                              return const SizedBox(
                                width: 23,
                              );
                            }
                            MealMentorCategory items =
                                c.itemCategory[index - 1];

                            final selected = c.selectedIndex.value == items.id;
                            return InkWell(
                              onTap: () {
                                c.selectedIndex.value = items.id!;
                                c.itemCategory.refresh();
                                c.getAllItemByCategory(c.selectedIndex.value);
                              },
                              child: Container(
                                height: 50,
                                margin:
                                    const EdgeInsets.only(left: 3, right: 3),
                                decoration: BoxDecoration(
                                  border: selected
                                      ? Border.all(
                                          color: AppColors.secondaryColor,
                                          width: 1)
                                      : null,
                                  color: colors[colorIndex],
                                  shape: BoxShape.rectangle,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(50)),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 9),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      items.name ?? "",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13,
                                        // color: AppColors.primaryColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 23),
                      child: Text(
                        "Items",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    SizedBox(
                      // height: Get.height / 1,
                      child: (c.loading1.value)
                          ? const Center(child: CircularProgressIndicator())
                          : ((c.itmeByCategory.isNotEmpty)
                              ? Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 23),
                                  child: GridView.builder(
                                    physics:
                                        const ScrollPhysics(), // to disable GridView's scrolling
                                    shrinkWrap: true,
                                    itemCount: c.itmeByCategory.length,
                                    // physics: const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisExtent: 169,
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 20.0,
                                      mainAxisSpacing: 20.0,
                                    ),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      MealMentorItem mmItem =
                                          c.itmeByCategory[index];
                                      return AllItemCard(
                                        items: mmItem,
                                      );
                                    },
                                  ),
                                )
                              : const Center(
                                  child: Text(
                                    "No Items in this Category",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                )),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class AllItemCard extends StatelessWidget {
  AllItemCard({
    Key? key,
    required this.items,
  }) : super(key: key);

  final MealMentorItem items;

  final c = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 0),
      height: 160,
      width: Get.width / 2.4,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
        boxShadow: [
          BoxShadow(
            offset: const Offset(4, 4),
            blurRadius: 9,
            color: const Color(0xFF494949).withOpacity(0.1),
          ),
        ],
      ),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(9)),
              width: double.infinity,
              // color: Colors.amber,
              height: 110,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                child: CachedNetworkImage(
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  fit: BoxFit.fill,
                  imageUrl: items.photo ?? "",
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/images/logo.png',
                    height: 87,
                    fit: BoxFit.contain,
                  ),
                  height: 87,
                ),
              )),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: Get.width / 5,
                      child: Text(
                        items.name ?? "",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        softWrap: false,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      items.price ?? "",
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondaryColor,
                  padding: const EdgeInsets.only(
                      left: 3, right: 3, top: 2, bottom: 2),
                  minimumSize: const Size(13, 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () {
                  final index =
                      c.cartItem.indexWhere((item) => item.id == items.id);
                  if (index != -1) {
                    // Update quantity of existing item
                    c.cartItem[index].itemCount++;
                  } else {
                    // Add new item to cart list
                    c.cartItem.add(items);
                  }
                  c.cartItem.refresh();
                },
                child: const Icon(
                  Icons.add,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
