import 'package:flutter/material.dart';

import '../../resources/resources.dart';

class EglRoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  final bool loading;
  final Color color, textColor;

  const EglRoundButton({
    super.key,
    required this.title,
    required this.onPress,
    this.color = AppColors.primaryColor,
    this.textColor = AppColors.whiteColor,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loading ? null : onPress,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: loading
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.white,
              ))
            : Center(
                child: Text(
                  title,
                  style: AppTheme.headline2.copyWith(fontSize: 16, color: textColor),
                ),
              ),
      ),
    );
  }
}
