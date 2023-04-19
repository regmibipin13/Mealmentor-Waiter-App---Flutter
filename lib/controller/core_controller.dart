import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/user.dart';
import '../utils/storage_keys.dart';
import '../views/auth/login.dart';

class CoreController extends GetxController {
  Rx<User?> currentUser = Rxn<User>();
  Rx<String> accessToken = " ".obs;
  Rx<ThemeMode> themeMode = Rx<ThemeMode>(ThemeMode.system);

  @override
  void onInit() async {
    loadCurrentUser();
    super.onInit();
  }

  Future<void> loadCurrentUser() async {
    currentUser.value = StorageHelper.getUser();
    accessToken.value = StorageHelper.getToken();
  }

  bool isUserLoggedIn() {
    return currentUser.value != null;
  }

  // void updateTheme(ThemeMode themeMode) async {
  //   this.themeMode.value = themeMode;
  //   final box = GetStorage();
  //   await box.write("ThemeMode", themeMode.toString());
  //   update();
  // }

  // void getTheme() {
  //   try {
  //     final box = GetStorage();
  //     var themeData = box.read("ThemeMode");
  //     log("$themeData ====================> Fetched");
  //     if (themeData == ThemeMode.light.toString()) {
  //       updateTheme(ThemeMode.light);
  //     } else if (themeData == ThemeMode.dark.toString()) {
  //       updateTheme(ThemeMode.dark);
  //     } else if (themeData == ThemeMode.system.toString()) {
  //       updateTheme(ThemeMode.system);
  //     }
  //   } catch (e, s) {
  //     log(e.toString());
  //     log(s.toString());
  //   }
  // }

  void logOut() async {
    final box = GetStorage();
    await box.write(StorageKeys.ACCESS_TOKEN, null);
    await box.write(StorageKeys.USER, null);
    loadCurrentUser();
    Get.offAllNamed(LoginScreen.routeName);
  }
}
