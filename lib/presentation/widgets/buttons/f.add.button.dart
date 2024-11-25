import 'package:flutter/material.dart';
import 'package:fluttrix/utils/app.colors.dart';
import 'package:lucide_icons/lucide_icons.dart';

class FAddButton extends StatelessWidget {
  const FAddButton({
    super.key,
    this.onPressed,
    required this.title,
  });
  final VoidCallback? onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      height: 35,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: AppColors.buttonColor,
          )),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            LucideIcons.plus,
            size: 20,
            color: AppColors.buttonColor,
          ),
          Text(title, style: TextStyle(
            fontSize: 14,
            color: AppColors.buttonColor,
          ),)
        ],
      ),
    );
  }
}
