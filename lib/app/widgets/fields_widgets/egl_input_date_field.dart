import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EglInputDateField extends StatelessWidget {
  const EglInputDateField({
    super.key,
    required this.dateController,
    required this.onChanged,
    required this.onValidator,
    required this.firstDate,
    required this.lastDate,
    required this.textDate,
    this.labelText = '',
    this.paddingLeft = 20,
    this.paddingRight = 20,
    this.paddingTop = 0,
    this.paddingBottom = 0,
    this.languageCode = 'es',
    this.countryCode = 'ES',
    this.contentPaddingLeft = 6,
    this.contentPaddingRight = 6,
    this.contentPaddingTop = 12,
    this.contentPaddingBottom = 12,
    this.focusNode,
    this.nextFocusNode,
    this.icon,
    this.iconLabel,
    this.ronudIconBorder = false,
    this.readOnly = false,
    this.borderRadius = 30,
    this.borderColor = Colors.redAccent,
    this.enabledBorderWidth = 1,
    this.borderWidth = 1,
    this.borderFocusColor = Colors.redAccent,
    this.focusedBorderWidth = 2,
    this.prefixIconPaddingLeft = 30,
    this.prefixIconPaddingRight = 10,
    this.prefixIconPaddingTop = 0,
    this.prefixIconPaddingBottom = 0,
    this.canReset = true,
  });

  final Rx<DateTime> dateController;
  final Rx<DateTime> firstDate;
  final Rx<DateTime> lastDate;
  final Rx<String> textDate;

  final ValueChanged<DateTime> onChanged;
//   final VoidCallback onTap;

  final FormFieldValidator<String> onValidator;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final IconData? icon;
  final IconData? iconLabel;
  final bool ronudIconBorder;
  final bool readOnly;
  final bool canReset;
  final String labelText;
  final double paddingLeft;
  final double paddingRight;
  final double paddingTop;
  final double paddingBottom;
  final String languageCode;
  final String countryCode;

  final double borderRadius;
  final Color borderColor;
  final double enabledBorderWidth;
  final double borderWidth;
  final Color borderFocusColor;
  final double focusedBorderWidth;
  final double contentPaddingLeft;
  final double contentPaddingRight;
  final double contentPaddingTop;
  final double contentPaddingBottom;
  final double prefixIconPaddingLeft;
  final double prefixIconPaddingRight;
  final double prefixIconPaddingTop;
  final double prefixIconPaddingBottom;

  @override
  Widget build(BuildContext context) {
    return FormField<DateTime>(
      builder: (FormFieldState<DateTime> state) {
        return InputDecorator(
          decoration: InputDecoration(
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
            helperText: '',
            helperMaxLines: 2,
            prefixIcon: icon == null
                ? null
                : IconButton(
                    onPressed: () {},
                    icon: Icon(
                      icon,
                      color: Colors.blue,
                    )), // adjust size as needed
            errorMaxLines: 2,
            errorStyle: const TextStyle(
              height: 1,
              fontSize: 11,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => _selectDate(context, state),
                  // child: buildDateTimePicker(textDate.value),
                  child: buildDateTimePicker(
                      dateController.value.isAtSameMomentAs(DateTime(4000)) ? 'dd/mm/aaaa' : DateFormat('dd/MM/yyyy').format(dateController.value)),
                ),
              ),
              if (canReset && dateController.value != DateTime(4000))
                InkWell(
                  onTap: () async {
                    dateController.value = DateTime(4000);
                    state.didChange(dateController.value);
                    onChanged(dateController.value);
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Icon(
                      Icons.cancel_outlined,
                      color: Color.fromRGBO(224, 57, 6, 1),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
      validator: (value) {
        if (value == null) {
          return 'mSelectDate'.tr;
        }
        return null;
      },
    );
  }

  Widget buildDateTimePicker(String data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(10.0),
      //   side: const BorderSide(color: Color.fromRGBO(92, 67, 83, 1), width: 0.5),
      // ),
      children: [
        Text(
          data,
          style: const TextStyle(fontSize: 14),
        ),
        const Icon(
          Icons.calendar_today,
          color: Color.fromRGBO(92, 67, 83, 1),
        ),
      ],
    );
  }

  String convertDate(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  Future<void> _selectDate(BuildContext context, FormFieldState<DateTime> state) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        helpText: 'Select date',
        initialDate: dateController.value.isAtSameMomentAs(DateTime(4000)) ? firstDate.value : dateController.value,
        firstDate: firstDate.value,
        lastDate: lastDate.value,
        locale: Locale(languageCode),
        currentDate: DateTime.now(),
        initialEntryMode: DatePickerEntryMode.calendar,
        initialDatePickerMode: DatePickerMode.day,
        fieldLabelText: 'Fechita',
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.blueGrey,
              accentColor: const Color.fromRGBO(58, 46, 46, 1),
              backgroundColor: Colors.lightBlue,
              cardColor: Colors.white,
            )),
            child: child!,
          );
        });

    if (pickedDate != null && pickedDate != dateController.value) {
      dateController.value = pickedDate;
      state.didChange(pickedDate);
      onChanged(dateController.value);
    }
  }

  // showDatePicker({
  // it requires a context
  //   required BuildContext context,
  // when datePicker is displayed, it will show month of the current date
  //   required DateTime initialDate,
  // earliest possible date to be displayed (eg: 2000)
  //   required DateTime firstDate,
  // latest allowed date to be displayed (eg: 2050)
  //   required DateTime lastDate,
  // it represents TODAY and it will be highlighted
  //   DateTime? currentDate,
  // either by input or selected, defaults to calendar mode.
  //   DatePickerEntryMode initialEntryMode = DatePickerEntryMode.calendar, // or input,
  // restricts user to select date from range to dates.
  //   SelectableDayPredicate? selectableDayPredicate,
  // text that is displayed at the top of the datePicker
  //   String? helpText,
  // text that is displayed on cancel button
  //   String? cancelText,
  // text that is displayed on confirm button
  //   String? confirmText,
  // use builder function to customise the datePicker
  //   TransitionBuilder? builder,
  // option to display datePicker in year or day mode. Defaults to day
  //   DatePickerMode initialDatePickerMode = DatePickerMode.day, // or year,
  // error message displayed when user hasn't entered date in proper format
  //   String? errorFormatText,
  // error message displayed when date is not selectable
  //   String? errorInvalidText,
  // hint message displayed to prompt user to enter date according to the format mentioned (eg: dd/mm/yyyy)
  //   String? fieldHintText,
  // label message displayed for what the user is entering date for (eg: birthdate)
  //   String? fieldLabelText,
  // }) {}

  // end class
}
