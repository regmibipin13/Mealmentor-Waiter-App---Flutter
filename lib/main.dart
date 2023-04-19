import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meal_mentor/controller/cart_controller.dart';
import 'package:meal_mentor/controller/core_controller.dart';
import 'package:meal_mentor/utils/page.dart';
import 'package:meal_mentor/utils/theme.dart';
import 'package:meal_mentor/views/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meal Mentor',
      darkTheme: ThemeData.dark(),
      initialRoute: SplashScreen.routeName,
      theme: basicTheme(),
      initialBinding: BindingsBuilder(() {
        Get.put(CoreController());
        Get.put(CartController());
      }),
      getPages: commonPages,
    );
  }
}
