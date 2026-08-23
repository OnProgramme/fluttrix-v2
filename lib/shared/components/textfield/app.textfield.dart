import 'package:flutter/material.dart';
import 'package:fluttrix/shared/form/validator/validator.dart';
import 'package:fluttrix/utils/app.colors.dart';
import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.label,
    this.onChanged,
    this.initialValue,
    this.controller,
    this.hint,
    this.maxLines = 1,
    this.minLines = 1,
    this.prefixIcon,
    this.keyboardType,
    this.isPassword = false,
    this.validators,
  });
  final String? label;
  final String? hint;
  final ValueSetter<String>? onChanged;
  final String? initialValue;
  final TextEditingController? controller;
  final int minLines;
  final int maxLines;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final bool isPassword;
  final List<ValidatorType>? validators;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscrure = false;

  @override
  void initState() {
    super.initState();
    _obscrure = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: Get.textTheme.labelLarge?.copyWith(
              color: AppColors.white,
            ),
          ),
          SizedBox(height: 5)
        ],
        TextFormField(
          obscureText: _obscrure,
          keyboardType: widget.keyboardType,
          controller: widget.controller,
          initialValue: widget.initialValue,
          onChanged: widget.onChanged,
          minLines: widget.minLines,
          maxLines: widget.maxLines,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 14,
              ),
          decoration: InputDecoration(
              prefixIcon: widget.prefixIcon,
              hintText: widget.hint,
              isDense: true,
              hintStyle: TextStyle(
                color: AppColors.grey,
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
              suffixIcon: widget.isPassword
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          _obscrure = !_obscrure;
                        });
                      },
                      icon: Icon(
                          _obscrure ? LucideIcons.eye : LucideIcons.eyeOff),
                    )
                  : null),
          validator: (value) {
            if (widget.validators == null) {
              return null;
            }
            for (var validator in widget.validators!) {
              if (validator(value!) != null) {
                return validator.call(value);
              }
            }
            return null;
          },
        ),
      ],
    );
  }
}
