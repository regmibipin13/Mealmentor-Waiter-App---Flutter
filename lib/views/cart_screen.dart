import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_mentor/controller/cart_controller.dart';
import 'package:meal_mentor/models/meal_mentor_item.dart';
import 'package:meal_mentor/utils/colors.dart';
import 'package:meal_mentor/views/dashboard/dash_screen.dart';
import 'package:meal_mentor/widgets/custom_button.dart';

import '../models/meal_mentor_table.dart';
import '../utils/custom_snackbar.dart';
import '../utils/image_paths.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart-screen';
  CartScreen({super.key});

  final c = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.extraWhiteLight,
          elevation: 5,
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
          shadowColor: AppColors.shadowColor,
          title: const Image(
            image: AssetImage(
              ImagesPath.logo,
            ),
            height: 80,
            width: 100,
          ),
          centerTitle: true,
        ),
        body: Obx(
          () => c.cartItem.isEmpty
              ? SizedBox(
                  child: Column(
                    children: const [
                      Image(image: AssetImage(ImagesPath.emptyCart)),
                      Text(
                        "No items in the cart",
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                )
              : SizedBox(
                  child: ListView.builder(
                      itemCount: c.cartItem.length,
                      itemBuilder: (context, index) {
                        MealMentorItem mealMentorItem = c.cartItem[index];
                        return CategoryCard(
                          textTheme: textTheme,
                          mmItems: mealMentorItem,
                        );
                      }),
                ),
        ),
        bottomNavigationBar: SizedBox(
          height: 80,
          child: Obx(() {
            if (c.allTableList.isEmpty || c.cartItem.isEmpty) {
              return Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                child: CustomElevatedButton(
                    onTap: () {
                      // Get.off(DashScreen());\
                      CustomSnackBar.success(
                          title: "Order", message: "Order placed successfully");
                    },
                    buttonText: "Add Item"),
              );
            }
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: DropdownButtonFormField<MealMentorTable>(
                      decoration: const InputDecoration(
                        // labelText: 'Select a table',
                        border: OutlineInputBorder(),
                      ),
                      value: c.allTableList.first,
                      items: c.allTableList
                          .map((table) => DropdownMenuItem(
                                value: table,
                                child: Text(table.name!),
                              ))
                          .toList(),
                      onChanged: (selectedTable) {
                        c.setSelectedTable(selectedTable!);
                      },
                    ),
                  ),
                  // Send Order button
                  SizedBox(
                    height: 63,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: ElevatedButton(
                      onPressed: () {
                        final selectedTable = c.allTableList.firstWhere(
                            (table) => table == c.selectedTable.value,
                            orElse: () => c.allTableList.first);

                        final selectedTableId = (selectedTable.id);

                        int total = 0;

                        List<PostItems> items =
                            []; // create a list of PostItems

                        for (MealMentorItem item in c.cartItem) {
                          if (item != null) {
                            total += item.itemCount * int.parse(item.price!);

                            // create a PostItems object for each item in the cart
                            PostItems postItem = PostItems(
                                id: item.id,
                                quantity: item.itemCount,
                                price: int.parse(item.price!));
                            items.add(
                                postItem); // add the PostItems object to the list
                          }
                        }

                        // create the final object to be sent to the API
                        Map<String, dynamic> orderData = {
                          "table_id": selectedTableId,
                          "items": items.map((item) => item.toJson()).toList(),
                          "total": total.toString()
                        };
                        c.sendPosOrder(orderData);
                      },
                      child: const Text("Send Order"),
                    ),
                  )
                ],
              ),
            );
          }),
        ));
  }
}

class CategoryCard extends StatelessWidget {
  CategoryCard({
    super.key,
    required this.textTheme,
    required this.mmItems,
  });

  final TextTheme textTheme;

  final MealMentorItem mmItems;
  final c = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      margin: const EdgeInsets.only(top: 15, left: 20, right: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF828282).withOpacity(0.3),
            blurRadius: 9,
            offset: const Offset(4, 4),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                height: 70,
                width: 83,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: CachedNetworkImage(
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    fit: BoxFit.fill,
                    imageUrl: mmItems.photo ?? "",
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/images/logo.png',
                      height: 87,
                      fit: BoxFit.contain,
                    ),
                    height: 87,
                  ),
                ),
              ),
              const SizedBox(
                width: 9,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: Get.width / 3,
                    child: Text(
                      mmItems.name ?? "",
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
                    height: 9,
                  ),
                  Text(
                    '${mmItems.itemCount} x ${mmItems.price}',
                    style: textTheme.bodyMedium!.copyWith(
                      fontSize: 14,
                      color: AppColors.textColor,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${((mmItems.itemCount) * (int.parse(mmItems.price!)))}',
                    style: textTheme.bodyLarge!.copyWith(
                      fontSize: 16,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      c.incrementItemQuantity(mmItems);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 7, left: 7),
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Text(mmItems.itemCount.toString()),
                  InkWell(
                    onTap: () {
                      c.decrementItemQuantity(mmItems);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 7, left: 7),
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.remove,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  // minimumSize: Size(10, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  c.removeItem(mmItems);
                  // totalValue += ((mmItems.itemCount) * (int.parse(mmItems.price!)));
                  // log("----------lenghth of cart ${c.cartItem.length}-------");
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 11.5,
                    horizontal: 18,
                  ),
                  child: Text(
                    'Remove',
                    style: textTheme.bodyLarge!.copyWith(
                        fontSize: 12, color: AppColors.extraWhiteLight),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class PostItems {
  int? id;
  int? quantity;
  int? price;

  PostItems({this.id, this.quantity, this.price});

  PostItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['quantity'] = quantity;
    data['price'] = price;
    return data;
  }
}
