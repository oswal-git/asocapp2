// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:asocapp/app/config/config.dart';
import 'package:get/get.dart';

class EglAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EglAppBar({
    super.key,
    this.title = '',
    this.titleWidget,
    this.titleFontSize = 24,
    this.titleFontWeight = FontWeight.bold,
    required this.showBackArrow,
    this.leadingIcon,
    this.actions,
    this.leadingOnPressed,
    this.backgroundColor = EglColorsApp.backGroundBarColor,
    this.leadingWidget,
  });

  final Color backgroundColor;
  final String title;
  final Widget? titleWidget;
  final double titleFontSize;
  final FontWeight titleFontWeight;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final Widget? leadingWidget;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: AppBar(
          backgroundColor: backgroundColor,
          automaticallyImplyLeading: false,
          leading: showBackArrow
              ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Get.back(),
                )
              : leadingIcon != null
                  ? Builder(builder: (context) {
                      return IconButton(
                        onPressed: leadingOnPressed,
                        icon: Icon(leadingIcon),
                      );
                    })
                  : leadingWidget,
          title: title == ''
              ? titleWidget
              : Text(
                  title,
                  style: TextStyle(fontSize: titleFontSize, fontWeight: titleFontWeight),
                ),
          actions: actions),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(EglDataConfig.kToolbarHeigh);
}
