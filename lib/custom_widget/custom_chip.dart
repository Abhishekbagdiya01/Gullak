import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final label;
  final VoidCallback? voidCallback;
  final bgColor;
  CustomChip({required this.label, required this.voidCallback, this.bgColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: voidCallback,
      child: Chip(
        backgroundColor: bgColor,
        label: Text(label),
      ),
    );
  }
}
