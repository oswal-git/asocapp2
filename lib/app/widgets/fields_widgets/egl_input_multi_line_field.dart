// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

// import 'package:asociaciones/res/theme.dart';

class EglInputMultiLineField extends StatefulWidget {
  const EglInputMultiLineField({
    Key? key,
    required this.focusNode,
    required this.nextFocusNode,
    required this.onChanged,
    required this.onValidator,
    required this.currentValue,
    this.labelText = '',
    this.hintText = '',
    this.maxLines = 3,
    this.maxLength = TextField.noMaxLength,
    this.icon,
    this.iconLabel,
    this.ronudIconBorder = false,
    this.label = false,
  }) : super(key: key);

  final ValueChanged<String> onChanged;
  final FormFieldValidator<String> onValidator;
  final bool label;
  final String labelText;
  final String hintText;
  final String? currentValue;
  final int maxLength;
  final int maxLines;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final IconData? icon;
  final IconData? iconLabel;
  final bool ronudIconBorder;

  @override
  State<EglInputMultiLineField> createState() => _EglInputMultiLineFieldState();
}

class _EglInputMultiLineFieldState extends State<EglInputMultiLineField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: null,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      focusNode: widget.focusNode,
      onFieldSubmitted: (_) {
        widget.nextFocusNode?.requestFocus();
      },
      initialValue: widget.currentValue,
      validator: widget.onValidator,
      onChanged: widget.onChanged,
      style: const TextStyle(height: null),
      decoration: InputDecoration(
        //   labelText: (focusNode!.hasFocus || controller.text.isNotEmpty) ? label : hint,
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
            padding: EdgeInsets.only(left: widget.iconLabel == null ? 0.0 : 8.0),
            child: Text(
              widget.labelText,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ]),
        // labelText: widget.label ? null : widget.labelText,
        hintText: widget.hintText,
        helperText: '',
        prefixIcon: widget.icon == null
            ? null
            : IconButton(
                onPressed: () {},
                icon: Icon(
                  widget.icon,
                  color: Colors.blue,
                )), // adjust size s needed
        errorMaxLines: 2,
        errorStyle: const TextStyle(
          height: 1,
          fontSize: 11,
        ),
      ),
    );
  }
}
