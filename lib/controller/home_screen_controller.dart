import 'dart:developer';

import 'package:get/get.dart';
import 'package:meal_mentor/models/meal_mentor_category.dart';
import 'package:meal_mentor/models/meal_mentor_item.dart';

import '../repo/category_repo.dart';
import '../utils/custom_snackbar.dart';

class HomeController extends GetxController {
  RxBool loading = RxBool(false);
  RxBool loading1 = RxBool(false);

  RxList<MealMentorCategory> itemCategory = <MealMentorCategory>[].obs;
  RxList<MealMentorItem> itmeByCategory = <MealMentorItem>[].obs;

  RxInt selectedIndex = 0.obs;
  @override
  void onInit() {
    getAllCategory();

    super.onInit();
  }

  getAllCategory() async {
    loading.value = true;
    await ItemRepo.getCategory(
      onSuccess: (items) {
        loading.value = false;
        itemCategory.clear();
        itemCategory.addAll(items);
        final firstCategory =
            itemCategory.isNotEmpty ? itemCategory[0].id : null;
        selectedIndex.value = firstCategory!.toInt();
        getAllItemByCategory(selectedIndex.value);
      },
      onError: ((message) {
        loading.value = false;
        CustomSnackBar.error(title: "Item Category", message: message);
      }),
    );
  }

  getAllItemByCategory(int id) async {
    loading1.value = true;
    itmeByCategory.clear();
    await ItemRepo.getItemByCategory(
      id: id,
      onSuccess: (items) {
        loading1.value = false;
        itmeByCategory.addAll(items);
      },
      onError: ((message) {
        loading1.value = false;
        CustomSnackBar.error(title: "Item Category", message: message);
      }),
    );
  }
}
