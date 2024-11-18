import 'package:flutter/material.dart';

class FTrixDivider extends StatelessWidget {
  const FTrixDivider({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider()),
        SizedBox(
          width: 10,
        ),
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(child: Divider())
      ],
    );
  }
}
