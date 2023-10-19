// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class EglInputDateField extends StatelessWidget {
  // ignore: constant_identifier_names
  static const _100_YEAR = Duration(days: 365 * 100);

  EglInputDateField({
    Key? key,
    required this.onChanged,
    required this.currentValue,
    required this.onValidator,
    required this.label,
  }) : super(key: key);

  final ValueChanged<DateTime> onChanged;
  final DateTime? currentValue;
  final FormFieldValidator<DateTime> onValidator;
  final String label;

  String get _label {
    if (currentValue == null) return label;

    return DateFormat.yMMMd().format(currentValue!);
  }

  final Logger logger = Logger();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: FormField<DateTime>(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          initialValue: currentValue,
          builder: (formState) {
            late InputBorder shape;

            if (formState.hasError) {
              shape = Theme.of(context).inputDecorationTheme.errorBorder!;
            } else {
              shape = Theme.of(context).inputDecorationTheme.enabledBorder!;
            }
            return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Stack(
                children: [
                  _buildDateSelectListTile(shape, context, formState),
                  if (currentValue != null) _buildFloatingLabel(context),
                ],
              ),
              if (formState.hasError) _buildErrorText(formState, context),
            ]);
          }),
    );
  }

  Widget _buildErrorText(FormFieldState<DateTime> formState, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 8.0,
      ),
      child: Text(formState.errorText!, style: Theme.of(context).inputDecorationTheme.errorStyle),
    );
  }

  Widget _buildDateSelectListTile(InputBorder shape, BuildContext context, FormFieldState<DateTime> formState) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4.0,
      ),
      child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          shape: shape,
          trailing: const Icon(
            Icons.date_range,
            color: Colors.blue,
          ),
          title: Text(_label),
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now().subtract(_100_YEAR),
              lastDate: DateTime.now(),
            );

            if (date != null) {
              onChanged(date);
              formState.didChange(date);
            }
          }),
    );
  }

  Widget _buildFloatingLabel(BuildContext context) {
    return Positioned(
      left: 12.0,
      top: -2.0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Text(
          label,
          style: Theme.of(context).inputDecorationTheme.helperStyle,
        ),
      ),
    );
  }
}
