import 'package:asocapp/app/controllers/article/article_edit_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EglDatePiker extends StatelessWidget {
  const EglDatePiker({
    super.key,
    required this.onDateChanged,
    required this.selectedDate,
    required this.firstDate,
    required this.lastDate,
    this.labelText = '',
    this.readOnly = false,
    this.languageCode = 'es',
    this.countryCode = 'ES',
    this.paddingLeft = 20,
    this.paddingRight = 20,
    this.paddingTop = 0,
    this.paddingBottom = 0,
    this.icon,
    this.iconLabel,
    this.ronudIconBorder = false,
    this.contentPaddingLeft = 6,
    this.contentPaddingRight = 6,
    this.contentPaddingTop = 12,
    this.contentPaddingBottom = 12,
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

  final DateTime selectedDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final String labelText;
  final bool readOnly;
  final bool canReset;
  final String languageCode;
  final String countryCode;
  final double paddingLeft;
  final double paddingRight;
  final double paddingTop;
  final double paddingBottom;
  final IconData? icon;
  final IconData? iconLabel;
  final bool ronudIconBorder;
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

  final ValueChanged<DateTime> onDateChanged;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ArticleEditController>(
      init: ArticleEditController(),
      initState: (_) {},
      builder: (controller) => InputDecorator(
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
                onTap: () => _selectDate(context, controller),
                // child: Text(DateFormat('dd/MM/yyyy').format(selectedDate))),
                child:
                    buildDateTimePicker(selectedDate.isAtSameMomentAs(DateTime(4000)) ? 'dd/mm/aaaa' : DateFormat('dd/MM/yyyy').format(selectedDate)),
              ),
            ),
            if (canReset && selectedDate != DateTime(4000))
              InkWell(
                onTap: () async {
                  onDateChanged(DateTime(4000));
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
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, ArticleEditController controller) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        helpText: 'Select date',
        initialDate: selectedDate.isAtSameMomentAs(DateTime(4000)) ? firstDate : selectedDate,
        firstDate: firstDate,
        lastDate: lastDate,
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

    if (pickedDate != null && pickedDate != selectedDate) {
      onDateChanged(pickedDate);
      // onChanged(dateController.value);
    }
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
}
