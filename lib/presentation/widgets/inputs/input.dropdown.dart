import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputDropdownItem<T> {
  String  label;
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
    // this.validators,
  });

  final List<InputDropdownItem<T>> items;
  final ValueSetter<T> onChanged;
  final String? hint;
  final String? label;
  // final List<ValidatorType>? validators;
  final T? value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        if (label != null) ...<Widget>[
          Text(
            label!,
            style: Get.textTheme.labelLarge?.copyWith(
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
        ],
        DropdownButtonFormField<T>(
          isExpanded: true,
          items: items.map((item) {
            return DropdownMenuItem(
              value: item.value,
              child: Text(
                item.label,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            );
          }).toList(),
          value: value,
          onChanged: (value) {
            if (value == null) return;
            onChanged.call(value);
          },
          hint: hint == null ? null : Text(hint!),
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.keyboard_arrow_down),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 15)
          ),
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
      ],
    );
  }
}
