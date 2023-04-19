import 'package:flutter/material.dart';

import '../utils/colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onTap;
  final String buttonText;
  const CustomElevatedButton({
    Key? key,
    required this.onTap,
    required this.buttonText,
 TextStyle ? style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          maximumSize: const Size(double.infinity, 60),
          backgroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          )),
      child: Text(
        buttonText,
      ),
    );
  }
}
