// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

// import 'package:asociaciones/res/theme.dart';

class EglInputTextField extends StatefulWidget {
  const EglInputTextField({
    super.key,
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
    this.readOnly = false,
  });

  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String> onValidator;
  final String labelText;
  final String hintText;
  final String? currentValue;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final IconData? icon;
  final IconData? iconLabel;
  final bool ronudIconBorder;
  final bool readOnly;

  @override
  State<EglInputTextField> createState() => _EglInputTextFieldState();
}

class _EglInputTextFieldState extends State<EglInputTextField> {
  final Logger logger = Logger();
  @override
  Widget build(BuildContext context) {
    // Utils.eglLogger('w', 'EglInputTextField -> widget.currentValue: ${widget.currentValue}');
    return TextFormField(
      readOnly: widget.readOnly,
      focusNode: widget.focusNode,
      onFieldSubmitted: (_) {
        widget.nextFocusNode?.requestFocus();
      },
      initialValue: widget.currentValue,
      validator: widget.onValidator,
      onChanged: widget.onChanged,
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
