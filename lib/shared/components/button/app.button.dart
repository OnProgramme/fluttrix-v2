import 'package:flutter/material.dart';
import 'package:fluttrix/utils/app.colors.dart';

class AppButton extends StatelessWidget {
  const AppButton(
      {super.key,
      this.onPressed,
      required this.title,
      this.color,
      this.fullWidth = false});

  final VoidCallback? onPressed;
  final dynamic title;
  final Color? color;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    assert(title is String || title is Widget);

    return SizedBox(
      width: fullWidth ? double.infinity : null,
      child: MaterialButton(
        color: color ?? AppColors.buttonColor,
        height: 50,
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: title is Widget
            ? title
            : Text(
                title,
                style: TextStyle(
                  color: AppColors.white,
                ),
              ),
      ),
    );
  }
}
