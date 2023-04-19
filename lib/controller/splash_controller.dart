import 'dart:async';

import 'package:get/get.dart';
import 'package:meal_mentor/views/auth/login.dart';

import '../views/dashboard/dash_screen.dart';
import 'core_controller.dart';

class SplashController extends GetxController {
  final coreController = Get.find<CoreController>();

  @override
  void onInit() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        if (coreController.isUserLoggedIn()) {
          Get.offAndToNamed(DashScreen.routeName);
        } else {
          Get.offAllNamed(LoginScreen.routeName);
        }
      },
    );
    super.onInit();
  }
}
