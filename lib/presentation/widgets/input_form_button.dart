// ignore_for_file: deprecated_member_use

import 'package:booknstyle/core/constant/images.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class InputFormButton extends StatelessWidget {
  final Function() onClick;
  final String? titleText;
  final Icon? icon;
  final TextStyle? textStyle;
  final Color? color;
  final double? cornerRadius;
  final EdgeInsets padding;

  const InputFormButton({
    super.key,
    required this.onClick,
    this.titleText,
    this.textStyle,
    this.icon,
    this.color,
    this.cornerRadius,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClick,
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(padding),
        maximumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 28.sp)),
        minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 28.sp)),
        backgroundColor: MaterialStateProperty.all<Color>(
          color ?? Theme.of(context).primaryColor,
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(cornerRadius ?? 12.0),
          ),
        ),
      ),
      child: titleText != null
          ? Text(
              titleText!,
              style: const TextStyle(color: Colors.white),
            )
          : Image.asset(
              kFilterIcon,
              color: Colors.white,
              height: 22.sp,
              width: 22.sp,
            ),
    );
  }
}