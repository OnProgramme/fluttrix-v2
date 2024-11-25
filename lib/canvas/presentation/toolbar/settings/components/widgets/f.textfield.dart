import 'package:flutter/material.dart';
import 'package:fluttrix/utils/app.colors.dart';
import 'package:get/get.dart';

class FTextField extends StatelessWidget {
  const FTextField({
    super.key,
    this.label,
    this.onChanged,
    this.initialValue,
    this.controller,
    this.hint,
    this.maxLines = 1,
    this.minLines = 1
  });
  final String? label;
  final String? hint;
  final ValueSetter<String>? onChanged;
  final String? initialValue;
  final TextEditingController? controller;
  final int minLines;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: Get.textTheme.labelLarge?.copyWith(
              color: AppColors.white,
            ),
          ),
          SizedBox(height: 5)
        ],
        TextFormField(
          controller: controller,
          initialValue: initialValue,
          onChanged: onChanged,
          minLines: minLines,
          maxLines: maxLines,
          style: TextStyle(
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: hint,
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: AppColors.grey,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: AppColors.focusBorder,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: AppColors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
