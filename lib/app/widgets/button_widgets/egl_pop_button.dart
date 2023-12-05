// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../resources/resources.dart';

class EglPopButton extends StatelessWidget {
  const EglPopButton({
    super.key,
    required this.onPressed,
    required this.textButton,
    required this.edgeInsets,
    required this.textColor,
    required this.color,
    required this.fontSize,
  });

  final VoidCallback onPressed;
  final String textButton;
  final Color textColor;
  final Color color;
  final EdgeInsets edgeInsets;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: color, //.green.shade900,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Center(
          child: Padding(
            padding: edgeInsets,
            child: Text(textButton, style: AppTheme.headline2.copyWith(fontSize: fontSize, color: textColor)),
          ),
        ),
      ),
    );
  }
}
