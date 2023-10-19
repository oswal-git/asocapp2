import 'package:flutter/material.dart';

class StyleAvatarUser {
  double heigh;
  double width;
  double radius;
  double size;
  IconData icon;
  Color backgroundColor;

  StyleAvatarUser({
    this.heigh = 80,
    this.width = 80,
    this.radius = 60,
    this.size = 50,
    this.icon = Icons.person_3,
    this.backgroundColor = Colors.redAccent,
  });

  StyleAvatarUser copyWith({
    double? heigh,
    double? width,
    double? radius,
    double? size,
    IconData? icon,
    Color? backgroundColor,
  }) {
    return StyleAvatarUser(
      heigh: heigh ?? this.heigh,
      width: width ?? this.width,
      radius: radius ?? this.radius,
      size: size ?? this.size,
      icon: icon ?? this.icon,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }
}
