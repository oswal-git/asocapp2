// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../resources/resources.dart';

class EglInputPasswordField extends StatefulWidget {
  const EglInputPasswordField({
    super.key,
    required this.focusNode,
    required this.nextFocusNode,
    required this.onChanged,
    required this.onValidator,
    required this.currentValue,
    this.labelText = '',
    this.icon,
    this.iconLabel,
    this.ronudIconBorder = false,
  });

  final ValueChanged<String> onChanged;
  final FormFieldValidator<String> onValidator;
  final String labelText;
  final String? currentValue;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final IconData? icon;
  final IconData? iconLabel;
  final bool ronudIconBorder;

  @override
  State<EglInputPasswordField> createState() => _EglInputPasswordFieldState();
}

class _EglInputPasswordFieldState extends State<EglInputPasswordField> {
  final Logger logger = Logger();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      focusNode: widget.focusNode,
      onFieldSubmitted: (_) {
        widget.nextFocusNode?.requestFocus();
      },
      obscureText: _obscurePassword,
      initialValue: widget.currentValue,
      validator: widget.onValidator,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        //   labelText: (focusNode!.hasFocus || controller.text.isNotEmpty) ? label : hint,
        hintText: '******',
        hintStyle: AppTheme.bodyText2.copyWith(
          letterSpacing: 2,
        ),
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
        // prefixIcon: IconButton(
        //     onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
        //     icon: const Icon(
        //       Icons.key,
        //       color: Colors.blue,
        //     )), // adjust size as needed
        suffixIcon: IconButton(
            onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
            icon: Icon(
              _obscurePassword ? Icons.visibility : Icons.visibility_off,
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
