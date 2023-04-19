import 'package:get/get.dart';

class DashScreenController extends GetxController {
  RxInt currentIndex = RxInt(0);


  void onItemTapped(int index) {
    currentIndex.value = index;
  }
}
