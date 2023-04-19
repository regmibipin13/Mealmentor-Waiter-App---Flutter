import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_mentor/controller/order_controller.dart';
import 'package:meal_mentor/models/past_order.dart';

import '../../utils/colors.dart';

class PastOrderScreen extends StatelessWidget {
  PastOrderScreen({super.key});

  final c = Get.find<OrderController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => (c.loading.value)
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: () async {
                  c.getAllPastorder();
                },
                child: Column(
                  children: [
                    Container(
                      margin:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: SizedBox(
                        height: Get.height - 275,
                        child: ListView.builder(
                            itemCount: c.pastOrderList.length,
                            itemBuilder: (context, index) {
                              PastOrder pastOrder = c.pastOrderList[index];
                              return ExpandablePanel(
                                theme: const ExpandableThemeData(
                                  headerAlignment:
                                      ExpandablePanelHeaderAlignment.center,
                                  tapBodyToCollapse: true,
                                ),
                                header: ListTile(
                                  title: Text(pastOrder.table!.name ?? "",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                  trailing: Text('Rs.${pastOrder.grandTotal}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: AppColors.secondaryColor)),
                                ),
                                expanded: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: pastOrder.orderableItems!.length,
                                  itemBuilder: (context, index) {
                                    PastOrderOrderableItems orderItem =
                                        pastOrder.orderableItems![index];
                                    return ListTile(
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Text("Item: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 13,
                                                      color: AppColors
                                                          .secondaryColor)),
                                              Text(
                                                orderItem.itemName!.name ?? "",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Rs. ${orderItem.price ?? ""}',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 13,
                                                    color: Colors.grey),
                                              ),
                                              const Text(
                                                "*",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 13,
                                                    color: Colors.grey),
                                              ),
                                              Text(
                                                orderItem.quantity ?? "",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 13,
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      trailing: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            children: [
                                              const Text('Total: ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 13,
                                                      color: AppColors
                                                          .secondaryColor)),
                                              Text(
                                                  "${int.parse(orderItem.quantity!) * int.parse(orderItem.price!)}",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 13,
                                                  )),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                collapsed: Container(),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
