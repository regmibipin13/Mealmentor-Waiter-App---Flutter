import 'package:flutter/material.dart';

import '../utils/colors.dart';

// import '../utils/colors.dart';

class CustomTextField extends StatelessWidget {
  final Function(String)? onValueChange;
  final bool autoFocus;
  final String? hint;
  final String? initial;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final TextCapitalization textCapitalization;
  final Color? border;
  final bool readOnly;
  final bool obscure;
  final Function()? onTap;
  final Function(String)? onSubmit;

  const CustomTextField({
    Key? key,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.onValueChange,
    this.controller,
    this.validator,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction = TextInputAction.done,
    this.textInputType = TextInputType.name,
    this.border,
    this.readOnly = false,
    this.onTap,
    this.initial,
    this.obscure = false,
    this.onSubmit,
    this.autoFocus = true,
    this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    const textTheme = TextStyle(
      fontFamily: "ZillaSlab",
      fontWeight: FontWeight.w400,
      fontSize: 16,
    );
    return TextFormField(
      autofocus: autoFocus,
      onFieldSubmitted: onSubmit,
      obscureText: obscure,
      onTap: (onTap != null) ? onTap! : null,
      readOnly: readOnly,
      keyboardType: textInputType,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      maxLines: 1,
      initialValue: initial,
      validator: (validator != null) ? validator : null,
      controller: (controller != null) ? controller : null,
      onChanged: (text) {
        if (onValueChange != null) {
          onValueChange!(text);
        }
      },
      decoration: InputDecoration(
        prefixIcon: (prefixIcon != null) ? prefixIcon : null,
        suffixIcon: (suffixIcon != null) ? suffixIcon : null,
        contentPadding: const EdgeInsets.all(16),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
              width: 1,
              color: (border == null) ? AppColors.borderColor : border!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
              width: 1,
              color: (border == null) ? AppColors.borderColor : border!),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(width: 1, color: theme.errorColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
              width: 1,
              color: (border == null) ? AppColors.borderColor : border!),
        ),
        hintText: hint ?? "",
        hintStyle: textTheme.copyWith(color: AppColors.hintTextColor),
        labelText: labelText,
      ),
      style: textTheme,
    );
  }
}
