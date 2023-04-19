import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:meal_mentor/controller/auth/login_controller.dart';
import 'package:meal_mentor/utils/colors.dart';
import 'package:meal_mentor/utils/image_paths.dart';

import '../../utils/validators.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login-screen';
  LoginScreen({super.key});

  final c = Get.find<LoginController>();

  final keys = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                color: AppColors.primaryColor,
                image: const DecorationImage(
                    image: AssetImage(ImagesPath.backgroundImage),
                    fit: BoxFit.fill,
                    opacity: 0.4),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(4, 4),
                    blurRadius: 9,
                    color: const Color(0xFF494949).withOpacity(0.6),
                  ),
                ],
              ),
              width: double.infinity,
              height: Get.height / 2.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  // Image(
                  //   image: AssetImage(
                  //     ImagesPath.logo,
                  //   ),
                  //   height: 80,
                  //   width: 80,
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Welcome ",
                    style: TextStyle(
                        color: AppColors.extraLightWhite,
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                  ),

                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    "To",
                    style: TextStyle(
                        color: AppColors.extraLightWhite,
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                  ),

                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    "Meal Mentor",
                    style: TextStyle(
                        color: AppColors.extraLightWhite,
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                  ),

                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "Login",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            Form(
              key: c.formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CustomTextField(
                      controller: c.emailController,
                      prefixIcon: const Icon(
                        Icons.person,
                        size: 20,
                      ),
                      validator: Validators.checkEmailField,
                      hint: "Username/Email ",
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    Obx(
                      (() => CustomTextField(
                            controller: c.passwordController,
                            validator: Validators.checkFieldEmpty,
                            prefixIcon: const Icon(
                              Icons.lock_outline,
                              size: 16,
                            ),
                            suffixIcon: InkWell(
                              onTap: c.onEyeClick,
                              child: SvgPicture.asset(
                                c.passwordObscure.value
                                    ? IconPath.EYE
                                    : IconPath.EYE_OFF,
                                color: AppColors.textColor,
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                            obscure: c.passwordObscure.value,
                            hint: "Password",
                            textInputAction: TextInputAction.done,
                            textInputType: TextInputType.emailAddress,
                          )),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    // Align(
                    //   alignment: Alignment.centerRight,
                    //   child: TextButton(
                    //     onPressed: () {},
                    //     child: const Text("Forgot Password ?"),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomElevatedButton(
                      buttonText: "Login",
                      onTap: c.onSubmit,
                      style: theme.textTheme.bodyLarge!.copyWith(
                        fontSize: 20,
                        color: AppColors.textColorAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const SizedBox(
        height: 50,
        child: Center(
          child: Image(
            image: AssetImage(
              'assets/images/logo.png',
            ),
            height: 50,
            width: 50,
          ),
        ),
      ),
    );
  }
}
