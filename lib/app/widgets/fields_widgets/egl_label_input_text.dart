// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class EglInputLabelText extends StatelessWidget {
  const EglInputLabelText({
    super.key,
    this.isLabelFilled = true,
    this.label = "",
    this.fontSize = 10,
    this.fontWeight = FontWeight.bold,
  });

  final bool isLabelFilled;
  final String label;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        alignment: Alignment.centerLeft,
        child: Text(
          isLabelFilled ? label : '',
          style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
        ),
      ),
    );
  }
}
