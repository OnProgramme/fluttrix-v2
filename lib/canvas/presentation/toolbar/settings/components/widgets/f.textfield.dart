import 'package:flutter/material.dart';

class FTextField extends StatelessWidget {
  const FTextField({
    super.key,
    this.label,
    this.onChanged,
    this.initialValue,
    this.controller,
    this.hint,
  });
  final String? label;
  final String? hint;
  final ValueSetter<String>? onChanged;
  final String? initialValue;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 5)
        ],
        TextFormField(
          controller: controller,
          initialValue: initialValue,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
