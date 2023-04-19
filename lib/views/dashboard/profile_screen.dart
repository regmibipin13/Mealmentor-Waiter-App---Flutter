import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/core_controller.dart';
import '../../utils/colors.dart';

class ProfileScreen extends StatelessWidget {
  
  static const routeName = '/profile_screen';
  final coreController = Get.find<CoreController>();
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: Get.height / 2.3,
                color: Colors.transparent,
                padding: const EdgeInsets.only(bottom: 150 / 2.2),
                child: Container(
                  width: size.width,
                  height: 150,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.elliptical(10, 10),
                        bottomRight: Radius.elliptical(10, 10)),
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://static.vecteezy.com/system/resources/previews/011/113/813/non_2x/aesthetic-abstract-gradient-red-wallpaper-illustration-perfect-for-wallpaper-backdrop-postcard-background-banner-for-your-design-vector.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              // * 1 backbutton (Row widget)

              // * user profile image
              Positioned(
                top: Get.height / 3.3,
                left: size.width / 2.5,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white, width: 3),
                      shape: BoxShape.circle),
                  child: const CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(
                        "https://st3.depositphotos.com/6672868/13701/v/600/depositphotos_137014128-stock-illustration-user-profile-icon.jpg"),
                  ),
                ),
              ),
            ],
          ),
          ProfileCard(
            content: coreController.currentUser.value?.name ?? "",
            iconData: Icons.person_2_outlined,
            title: 'Name',
          ),
          ProfileCard(
            content: coreController.currentUser.value?.email ?? "",
            iconData: Icons.mail,
            title: 'Email',
          ),
          ProfileCard(
            content: coreController.currentUser.value?.phone ?? "",
            iconData: Icons.phone,
            title: 'Contact',
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              // minimumSize: Size(10, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              coreController.logOut();
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 11.5,
                horizontal: 18,
              ),
              child: Text(
                'Log Out',
                style:
                    TextStyle(fontSize: 12, color: AppColors.extraWhiteLight),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    required this.title,
    required this.content,
    required this.iconData,
  });

  final String title;
  final String content;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      margin: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF828282).withOpacity(0.2),
            blurRadius: 9,
            offset: const Offset(4, 4),
          )
        ],
      ),
      child: Row(
        children: [
          Icon(iconData),
          const SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                title,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textColor),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                content,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
