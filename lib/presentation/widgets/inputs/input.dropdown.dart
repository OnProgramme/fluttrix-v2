import 'package:flutter/material.dart';
import 'package:fluttrix/utils/app.colors.dart';
import 'package:get/get.dart';

class InputDropdownItem<T> {
  String label;
  T value;
  InputDropdownItem(this.label, this.value);

  @override
  bool operator ==(Object other) {
    return super == other && other is InputDropdownItem && label == other.label;
  }
}

class InputDropdown<T> extends StatelessWidget {
  const InputDropdown({
    required this.items,
    required this.onChanged,
    super.key,
    this.hint,
    this.label,
    this.value,
    this.height = 35,
    // this.validators,
  });

  final List<InputDropdownItem<T>> items;
  final ValueSetter<T> onChanged;
  final String? hint;
  final String? label;
  // final List<ValidatorType>? validators;
  final T? value;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        if (label != null) ...<Widget>[
          Text(
            label!,
            style: Get.textTheme.labelLarge?.copyWith(
              color: AppColors.white,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
        ],
        SizedBox(
          height: height,
          child: DropdownButtonFormField<T>(
            isExpanded: true,
            items: items.map((item) {
              return DropdownMenuItem(
                value: item.value,
                child: Text(
                  item.label,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppColors.white,
                      ),
                ),
              );
            }).toList(),
            value: value,
            onChanged: (value) {
              if (value == null) return;
              onChanged.call(value);
            },
            hint: hint == null
                ? null
                : Text(
                    hint!,
                    style: TextStyle(color: AppColors.white),
                  ),
            style: TextStyle(
              color: AppColors.white,
            ),
            selectedItemBuilder: (context) {
              return items.map((item) {
                return Container(
                  color: AppColors.primary,
                  child: Text(
                    item.label,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppColors.white,
                        ),
                  ),
                );
              }).toList();
            },
            dropdownColor: AppColors.primary,
            decoration: InputDecoration(
                suffixIcon: Icon(Icons.keyboard_arrow_down),
                hintStyle: TextStyle(color: AppColors.grey),
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
                contentPadding: EdgeInsets.symmetric(horizontal: 15)),
            icon: const SizedBox(
              width: 0,
            ),
            // validator: (value) {
            //   if (validators == null) {
            //     return null;
            //   }
            //   for (var validator in validators!) {
            //     if (validator(value?.label ?? "") != null) {
            //       return validator.call(value?.label ?? "");
            //     }
            //   }
            // },
          ),
        ),
      ],
    );
  }
}
