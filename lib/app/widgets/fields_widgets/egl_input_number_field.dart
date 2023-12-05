// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// import 'package:asociaciones/res/theme.dart';

class EglInputNumberField extends StatefulWidget {
  const EglInputNumberField({
    super.key,
    required this.focusNode,
    required this.nextFocusNode,
    required this.onChanged,
    required this.onValidator,
    required this.currentValue,
    this.labelText = '',
    this.hintText = '',
    this.maxLength = 10,
    this.icon,
  });

  final ValueChanged<String> onChanged;
  final FormFieldValidator<String> onValidator;
  final String labelText;
  final String hintText;
  final int maxLength;
  final String? currentValue;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final IconData? icon;

  @override
  State<EglInputNumberField> createState() => _EglInputNumberFieldState();
}

class _EglInputNumberFieldState extends State<EglInputNumberField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: TextFormField(
        keyboardType: const TextInputType.numberWithOptions(
          decimal: true,
          signed: true,
        ),
        maxLength: widget.maxLength,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        focusNode: widget.focusNode,
        onFieldSubmitted: (_) {
          widget.nextFocusNode?.requestFocus();
        },
        initialValue: widget.currentValue,
        validator: widget.onValidator,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          //   labelText: (focusNode!.hasFocus || controller.text.isNotEmpty) ? label : hint,
          labelText: widget.labelText,
          helperText: '',
          hintText: widget.hintText,
          suffix: const Text('kg'),
          prefixIcon: widget.icon == null
              ? null
              : IconButton(
                  onPressed: () {},
                  icon: Icon(
                    widget.icon,
                    color: Colors.blue,
                  )), // adjust size as needed
        ),
      ),
    );
  }
}
