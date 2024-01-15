// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class EglCircleIconButton extends StatelessWidget {
  final IconData? icon;
  final VoidCallback? onPressed;
  final Color color;
  final Color backgroundColor;
  final double size;
  final String text;

  const EglCircleIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.color = Colors.black,
    this.backgroundColor = Colors.transparent,
    this.size = 30.0,
    this.text = '',
  });

  @override
  Widget build(BuildContext context) {
    double pad = (size - 10) / 5 + 4;
    double textTop = 2 * (size - 15) / 5;
    double textRight1 = 7 * (size - 15) / 15 + 5;
    double textRight2 = 8 * (size - 15) / 15 + 2;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor, // Ajusta según sea necesario
        ),
        child: Padding(
          padding: EdgeInsets.all(pad),
          child: Stack(children: [
            Icon(
              icon,
              color: color, // Ajusta según sea necesario
              size: size,
            ),
            if (text.isNotEmpty)
              Positioned(
                top: textTop, // Ajusta según sea necesario
                right: text.trim().length == 1 ? textRight1 : textRight2, // Ajusta según sea necesario
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
          ]),
        ),
      ),
    );
  }
}
