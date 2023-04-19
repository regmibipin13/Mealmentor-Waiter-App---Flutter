import 'package:get/get.dart';
import 'package:meal_mentor/controller/cart_controller.dart';
import 'package:meal_mentor/controller/home_screen_controller.dart';
import 'package:meal_mentor/views/cart_screen.dart';

import '../controller/auth/login_controller.dart';
import '../controller/dash_screen_controller.dart';
import '../controller/order_controller.dart';
import '../controller/profile_controller.dart';
import '../controller/splash_controller.dart';
import '../views/auth/login.dart';
import '../views/dashboard/dash_screen.dart';
import '../views/splash_screen.dart';

var commonPages = [
  GetPage(
      name: SplashScreen.routeName,
      page: (() => SplashScreen()),
      binding: BindingsBuilder(() => Get.lazyPut(() => SplashController()))),
  GetPage(
      name: LoginScreen.routeName,
      page: (() => LoginScreen()),
      binding: BindingsBuilder(() => Get.lazyPut(() => LoginController()))),
  GetPage(
      name: DashScreen.routeName,
      page: (() => DashScreen()),
      binding: BindingsBuilder(
        () {
          Get.lazyPut(() => DashScreenController());
          Get.lazyPut(() => HomeController());
          Get.lazyPut(() => OrderController());
          Get.lazyPut(() => ProfileController());
        },
      )),
  GetPage(
      name: CartScreen.routeName,
      page: (() => CartScreen()),
      binding: BindingsBuilder(() => Get.lazyPut(() => CartController()))),
];
