// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'package:asocapp/app/widgets/widgets.dart';

class EglAsociationsDropdown extends StatelessWidget {
  EglAsociationsDropdown({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.focusNode,
    this.nextFocusNode,
    required this.onChanged,
    required this.onValidate,
    required this.future,
    required this.currentValue,
  }) : super(key: key);

  final String labelText;
  final String hintText;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final FormFieldSetter? onChanged;
  final FormFieldValidator onValidate;
  final Future<List<dynamic>> future;
  final dynamic currentValue;

  final Logger logger = Logger();

  @override
  Widget build(BuildContext context) {
    // Utils.eglLogger('i', 'EglAsociationsDropdown -> currentValue: $currentValue');

    return FutureBuilder<List<dynamic>>(
        future: future,
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> asociations) {
          if (asociations.hasData) {
            return EglDropdownList(
              context: context,
              focusNode: focusNode,
              nextFocusNode: null,
              lstData: asociations.data!,
              // "Asociación",
              labelText: labelText,
              hintText: hintText,
              contentPaddingLeft: 20,
              value: currentValue,
              onChanged: onChanged,
              onValidate: onValidate,
              borderFocusColor: Theme.of(context).primaryColor,
              borderColor: Theme.of(context).primaryColor,
              paddingTop: 0,
              paddingLeft: 0,
              paddingRight: 0,
              paddingBottom: 0,
              borderRadius: 10,
              optionValue: "id",
              optionLabel: "name",
            );
          }

          return const CircularProgressIndicator();
        });
  }
}
