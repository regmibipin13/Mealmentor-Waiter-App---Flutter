import 'package:get/get.dart';
import 'package:meal_mentor/models/past_order.dart';
import 'package:meal_mentor/repo/order_repo.dart';

import '../utils/custom_snackbar.dart';

class OrderController extends GetxController {
  @override
  void onInit() {
    getAllPastorder();
    super.onInit();
  }

  RxBool loading = RxBool(false);
  RxBool showDetails = false.obs;

  RxBool pastDetails = false.obs;

  RxList<PastOrder> pastOrderList = <PastOrder>[].obs;
  RxList<PastOrder> activeOrderList = <PastOrder>[].obs;

  getAllPastorder() async {
    loading.value = true;
    await MealMentorOrderRepo.getPastOrder(
      onSuccess: (activeOrder, pastOrder) {
        pastOrderList.clear();
        activeOrderList.clear();
        loading.value = false;
        activeOrderList.addAll(activeOrder);
        pastOrderList.addAll(pastOrder);
      },
      onError: ((message) {
        loading.value = false;
        CustomSnackBar.error(title: "PastOrder", message: message);
      }),
    );
  }

  removeRemainingOrder(int tableId, int itemId) async {
    loading.value = true;
    await MealMentorOrderRepo.removeRemaimingOrderItem(
      tableId: tableId,
      itemId: itemId,
      onSuccess: () {
        loading.value = false;
        pastOrderList.clear();
        activeOrderList.clear();
        getAllPastorder();
        CustomSnackBar.error(title: "Order", message: "Item Removed sucefully");
      },
      onError: (message) {
        loading.value = false;
        CustomSnackBar.error(title: "PastOrder", message: message);
      },
    );
  }
}
