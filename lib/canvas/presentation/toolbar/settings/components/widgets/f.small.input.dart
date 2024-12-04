import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttrix/utils/app.colors.dart';
import 'package:get/get.dart';

class FSmallInput extends StatelessWidget {
  const FSmallInput({
    super.key,
    this.hint,
    this.initialValue,
    this.onChanged,
    this.controller,
    this.label,
    this.maxLength = 3,
  });
  final String? hint;
  final String? label;
  final String? initialValue;
  final ValueSetter<String>? onChanged;
  final TextEditingController? controller;
  final int maxLength;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
        SizedBox(
          width: 35,
          height: 35,
          child: TextFormField(
            controller: controller,
            onChanged: onChanged,
            initialValue: initialValue,
            buildCounter: (context,
                {required int currentLength,
                required bool isFocused,
                required int? maxLength}) {
              return null;
            },
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10),
            cursorHeight: 10,
            maxLength: maxLength,
            decoration: InputDecoration(
              hintStyle: TextStyle(
                color: AppColors.grey,
              ),
              isDense: false,
              hintText: hint,
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
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    );
  }
}
