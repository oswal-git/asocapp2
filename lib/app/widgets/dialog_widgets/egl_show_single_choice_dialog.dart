// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asocapp/app/models/models.dart';
import 'package:asocapp/app/utils/utils.dart';
import 'package:asocapp/app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ShowSingleChoiceDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onPressed;
  final String title2;
  final String message2;
  final EdgeInsets edgeInsetsPop;

  final String avatarUser;
  final TextStyle styleTitle;
  final TextStyle styleMessage;
  final TextStyle styleTitle2;
  final TextStyle styleMessage2;
  final ButtonStyle styleTextButton;
  final bool withImage;
  final StyleAvatarUser styleAvatarUser;
  final String textButton;
  final Color textColorButton;
  final Color colorButton;
  final EdgeInsets edgeInsetsButton;
  final double fontSizeButton;

  const ShowSingleChoiceDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onPressed,
    required this.title2,
    required this.message2,
    required this.edgeInsetsPop,
    required this.avatarUser,
    required this.styleTitle,
    required this.styleMessage,
    required this.styleTitle2,
    required this.styleMessage2,
    required this.styleTextButton,
    required this.withImage,
    required this.styleAvatarUser,
    required this.textButton,
    required this.textColorButton,
    required this.colorButton,
    required this.edgeInsetsButton,
    required this.fontSizeButton,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          FittedBox(
            // height: 280,
            fit: BoxFit.contain,
            child: Padding(
              padding: edgeInsetsPop,
              child: Column(
                children: [
                  Text(
                    title,
                    style: styleTitle,
                    textAlign: TextAlign.center,
                  ),
                  5.ph,
                  Text(
                    title2,
                    style: styleTitle2,
                    textAlign: TextAlign.center,
                  ),
                  5.ph,
                  Text(
                    message,
                    style: styleMessage,
                    textAlign: TextAlign.center,
                  ),
                  5.ph,
                  Text(
                    message2,
                    style: styleMessage2,
                    textAlign: TextAlign.center,
                  ),
                  20.ph,
                  EglPopButton(
                    onPressed: onPressed,
                    textButton: textButton,
                    edgeInsets: edgeInsetsButton,
                    textColor: textColorButton,
                    color: colorButton,
                    fontSize: fontSizeButton,
                  ),
                ],
              ),
            ),
          ),
          if (withImage)
            Positioned(
                top: (-1.0 * styleAvatarUser.radius),
                child: CircleAvatar(
                  backgroundColor: styleAvatarUser.backgroundColor,
                  // backgroundImage: avatarUser == '' ? null : NetworkImage(avatarUser, scale: .05),
                  radius: styleAvatarUser.radius,
                  child: avatarUser != ''
                      ? Image(image: NetworkImage(avatarUser), height: styleAvatarUser.heigh, width: styleAvatarUser.width)
                      : Icon(
                          styleAvatarUser.icon,
                          size: styleAvatarUser.size,
                          color: Colors.white,
                        ),
                ))
        ],
      ),
    );
  }
}
