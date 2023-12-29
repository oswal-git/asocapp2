// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class EglCircleIconButton extends StatelessWidget {
  final IconData icon;
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
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor, // Ajusta según sea necesario
        ),
        child: Stack(children: [
          Icon(
            icon,
            color: color, // Ajusta según sea necesario
            size: size,
          ),
          if (text.isNotEmpty)
            Positioned(
              top: 6.0, // Ajusta según sea necesario
              right: text.trim().length == 1 ? 12.0 : 10.0, // Ajusta según sea necesario
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
            ),
        ]),
      ),
    );
  }
}
