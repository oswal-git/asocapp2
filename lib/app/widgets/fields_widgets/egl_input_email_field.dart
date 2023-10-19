// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asocapp/app/utils/utils.dart';
import 'package:flutter/material.dart';

// import 'package:asociaciones/res/theme.dart';

class EglInputEmailField extends StatefulWidget {
  const EglInputEmailField({
    Key? key,
    required this.focusNode,
    required this.nextFocusNode,
    required this.onChanged,
    required this.onValidator,
    required this.currentValue,
    this.labelText = '',
    this.hintText = '',
    this.icon,
    this.iconLabel,
    this.ronudIconBorder = false,
  }) : super(key: key);

  final ValueChanged<String> onChanged;
  final FormFieldValidator<String> onValidator;
  final String labelText;
  final String hintText;
  final String? currentValue;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final IconData? icon;
  final IconData? iconLabel;
  final bool ronudIconBorder;

  @override
  State<EglInputEmailField> createState() => _EglInputEmailFieldState();
}

class _EglInputEmailFieldState extends State<EglInputEmailField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      focusNode: widget.focusNode,
      onFieldSubmitted: (_) {
        widget.nextFocusNode?.requestFocus();
      },
      initialValue: widget.currentValue,
      validator: (value) {
        if (widget.onValidator(value) != null) {
          return widget.onValidator(value);
        }

        if (!value!.isValidEmail()) {
          return 'Email incorrecto';
        }

        return null;
      },
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        label: Row(mainAxisSize: MainAxisSize.min, children: [
          if (widget.iconLabel != null)
            Container(
              decoration: widget.ronudIconBorder
                  ? BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                    )
                  : null,
              child: Icon(
                widget.iconLabel,
                size: widget.ronudIconBorder ? 16.0 : 22.0,
                color: Colors.black,
              ),
            ),
          Padding(
            padding: EdgeInsets.only(
              left: widget.iconLabel == null ? 0.0 : 8.0,
            ),
            child: Text(
              widget.labelText,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ]),
        helperText: '',
        helperMaxLines: 2,
        hintText: widget.hintText,
        prefixIcon: widget.icon == null
            ? null
            : IconButton(
                onPressed: () {},
                icon: Icon(
                  widget.icon,
                  color: Colors.blue,
                )), // adjust size as needed
        errorMaxLines: 2,
        errorStyle: const TextStyle(
          height: 1,
          fontSize: 11,
        ),
      ),
    );
  }
}
