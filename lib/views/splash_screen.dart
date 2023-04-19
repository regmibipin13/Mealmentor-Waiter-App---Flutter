import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = '/splash-screen';

  final c = Get.find<SplashController>();
  SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Image(
        image: AssetImage(
          'assets/images/logo.png',
        ),
        height: 100,
        width: 200,
      ),
    ),);
  }
}
