import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

import '../../repo/auth/login_repo.dart';
import '../../utils/custom_snackbar.dart';
import '../../utils/storage_keys.dart';
import '../../views/dashboard/dash_screen.dart';
import '../core_controller.dart';

class LoginController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var passwordObscure = true.obs;
  void onEyeClick() {
    passwordObscure.value = !passwordObscure.value;
  }

  final loading = SimpleFontelicoProgressDialog(
      context: Get.context!, barrierDimisable: false);

  final bearerToken = ''.obs;

  final formKey = GlobalKey<FormState>();

  void onSubmit() async {
    if (formKey.currentState!.validate()) {
      loading.show(message: "Logging In");
      await LoginRepo.login(
        email: emailController.text,
        password: passwordController.text,
        onSuccess: (user, token) async {
          loading.hide();
          final box = GetStorage();
          await box.write(StorageKeys.USER, json.encode(user.toJson()));
          await box.write(StorageKeys.ACCESS_TOKEN, token.toString());
          Get.find<CoreController>().loadCurrentUser();
          bearerToken.value = token.toString();
          Get.offAllNamed(DashScreen.routeName);
          CustomSnackBar.success(
              title: "Login", message: "Congrats. Login Successfull");
        },
        onError: (message) {
          loading.hide();
          CustomSnackBar.error(title: "Failed", message: message);
        },
      );
    }
  }
}
