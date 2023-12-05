// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class EglDropdownList extends StatelessWidget {
  const EglDropdownList({
    super.key,
    required this.context,
    required this.focusNode,
    required this.nextFocusNode,
    required this.lstData,
    this.labelText = '',
    required this.hintText,
    required this.value,
    required this.onChanged,
    required this.onValidate,
    this.hintFontSize = 12,
    this.paddingLeft = 20,
    this.paddingRight = 20,
    this.paddingTop = 0,
    this.paddingBottom = 0,
    this.contentPaddingLeft = 6,
    this.contentPaddingRight = 6,
    this.contentPaddingTop = 6,
    this.contentPaddingBottom = 6,
    this.validationColor = Colors.redAccent,
    this.hintColor = Colors.black,
    this.borderRadius = 30,
    this.borderColor = Colors.redAccent,
    this.enabledBorderWidth = 1,
    this.borderWidth = 2,
    this.borderFocusColor = Colors.redAccent,
    this.focusedBorderWidth = 2,
    this.suffixIcon,
    this.prefixIcon,
    this.showPrefixIcon = false,
    this.prefixIconColor = Colors.redAccent,
    this.prefixIconPaddingLeft = 30,
    this.prefixIconPaddingRight = 10,
    this.prefixIconPaddingTop = 0,
    this.prefixIconPaddingBottom = 0,
    this.optionValue = "id",
    this.optionLabel = "name",
    this.icon,
    this.iconLabel,
    this.ronudIconBorder = false,
  });

  final BuildContext context;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final List<dynamic> lstData;
  final String labelText;
  final String hintText;
  final dynamic value;
  final FormFieldSetter? onChanged;
  final FormFieldValidator onValidate;
  final double hintFontSize;
  final double paddingLeft;
  final double paddingRight;
  final double paddingTop;
  final double paddingBottom;
  final double contentPaddingLeft;
  final double contentPaddingRight;
  final double contentPaddingTop;
  final double contentPaddingBottom;
  final Color validationColor;
  final Color hintColor;
  final double borderRadius;
  final Color borderColor;
  final double enabledBorderWidth;
  final double borderWidth;
  final Color borderFocusColor;
  final double focusedBorderWidth;
  final Widget? suffixIcon;
  final Icon? prefixIcon;
  final bool showPrefixIcon;
  final Color prefixIconColor;
  final double prefixIconPaddingLeft;
  final double prefixIconPaddingRight;
  final double prefixIconPaddingTop;
  final double prefixIconPaddingBottom;
  final String optionValue;
  final String optionLabel;
  final IconData? icon;
  final IconData? iconLabel;
  final bool ronudIconBorder;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: paddingLeft,
        right: paddingRight,
        top: paddingTop,
        bottom: paddingBottom,
      ),
      child: FormField<dynamic>(
        builder: (FormFieldState<dynamic> state) {
          return DropdownButtonFormField<String>(
            focusNode: focusNode,
            isExpanded: true,
            value: value != "" ? value : null,
            hint: Padding(
              padding: EdgeInsets.only(left: iconLabel == null ? 0.0 : 18.0),
              child: Text(
                hintText,
                style: TextStyle(
                  fontSize: hintFontSize,
                ),
              ),
            ),
            decoration: InputDecoration(
              isDense: false,
              label: Row(mainAxisSize: MainAxisSize.min, children: [
                if (iconLabel != null)
                  Container(
                    decoration: ronudIconBorder
                        ? BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.black,
                              width: 2,
                            ),
                          )
                        : null,
                    child: Icon(
                      iconLabel,
                      size: ronudIconBorder ? 16.0 : 22.0,
                      color: Colors.black,
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.only(
                    left: iconLabel == null ? 0.0 : 8.0,
                  ),
                  child: Text(
                    labelText,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ]),
              contentPadding: EdgeInsets.only(
                left: contentPaddingLeft,
                right: contentPaddingRight,
                top: contentPaddingTop,
                bottom: contentPaddingBottom,
              ),
              errorMaxLines: 2,
              errorStyle: TextStyle(
                height: 1,
                fontSize: 11,
                color: validationColor,
              ),
              hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: hintFontSize,
                color: hintColor,
              ),
              hintText: hintText,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(
                  color: borderColor,
                  width: enabledBorderWidth,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(
                  color: borderColor,
                  width: borderWidth,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: borderFocusColor,
                  width: focusedBorderWidth,
                ),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              suffixIcon: suffixIcon,
              prefixIcon: showPrefixIcon
                  ? Padding(
                      padding: EdgeInsets.only(
                        left: prefixIconPaddingLeft,
                        right: prefixIconPaddingRight,
                        top: prefixIconPaddingTop,
                        bottom: prefixIconPaddingBottom,
                      ),
                      child: IconTheme(
                        data: IconThemeData(color: prefixIconColor),
                        child: prefixIcon!,
                      ),
                    )
                  : null,
            ),
            onChanged: onChanged,
            validator: onValidate,
            items: lstData.map<DropdownMenuItem<String>>(
              (dynamic data) {
                return DropdownMenuItem<String>(
                  value: data[optionValue].toString(),
                  child: Text(
                    data[optionLabel],
                    style: const TextStyle(color: Colors.black, fontSize: 13),
                  ),
                );
              },
            ).toList(),
          );
        },
      ),
    );
  }
}
