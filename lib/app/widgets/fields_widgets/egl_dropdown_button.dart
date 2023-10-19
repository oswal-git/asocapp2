// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:asocapp/app/resources/resources.dart';
import 'package:asocapp/app/utils/utils.dart';
import 'package:flutter/material.dart';

import 'package:logger/logger.dart';

class EglDropdownButtonItem {
  EglDropdownButtonItem({
    required this.id,
    required this.name,
    required this.image,
  });

  int id;
  String name;
  String image;

  factory EglDropdownButtonItem.clear() => EglDropdownButtonItem(
        id: 0,
        name: '',
        image: '',
      );
}

class EglDropdownButtonField extends StatefulWidget {
  const EglDropdownButtonField({
    Key? key,
    required this.hint,
    this.image = '',
    required this.list,
    required this.controller,
    this.iniSelectedItem,
    required this.focusNode,
    this.icon,
    required this.onFieldSubmitedValue,
    required this.onValidator,
    this.enable = false,
    this.autofocus = false,
    required this.onWidgetChanged,
  }) : super(key: key);

  final String hint;
  final String image;
  final List<EglDropdownButtonItem> list;
  final TextEditingController controller;
  final EglDropdownButtonItem? iniSelectedItem;
  final FocusNode focusNode;
  final Icon? icon;
  final FormFieldSetter onFieldSubmitedValue;
  final FormFieldValidator onValidator;

  final bool enable;
  final bool autofocus;
  final void Function(EglDropdownButtonItem) onWidgetChanged;

  @override
  State<EglDropdownButtonField> createState() => _EglDropdownButtonFieldState();
}

class _EglDropdownButtonFieldState extends State<EglDropdownButtonField> {
  bool isOpen = false;
  EglDropdownButtonItem selectedItem = EglDropdownButtonItem.clear();

  final Logger logger = Logger();

  @override
  void initState() {
    super.initState();
    selectedItem = widget.iniSelectedItem ?? EglDropdownButtonItem.clear();
    widget.controller.text = selectedItem.name;

    logger.i('widget selectedItem: ${widget.iniSelectedItem?.name}');
    logger.i('selectedItem: ${selectedItem.name}');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    logger.i('selectedItem 2: ${selectedItem.name}');
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                isOpen = !isOpen;
                setState(() {});
              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.whiteColor,
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.textFieldDefaultFocus,
                    ),
                  ),
                ),
                child: TextFormField(
                  style: TextStyle(
                    fontSize: selectedItem.name.length > 40
                        ? 9.6
                        : selectedItem.name.length > 20
                            ? 12
                            : 14,
                    color: Colors.black,
                  ),
                  controller: widget.controller,
                  focusNode: widget.focusNode,
                  onFieldSubmitted: widget.onFieldSubmitedValue,
                  validator: widget.onValidator,
                  decoration: InputDecoration(
                    enabled: false,
                    hintText: widget.hint,
                    hintStyle: AppTheme.bodyText2.copyWith(
                      // height: 0,
                      color: AppColors.primaryTextTextColor.withOpacity(0.8),
                      fontSize: selectedItem.name.length > 40 ? 12 : 14,
                    ),
                    contentPadding: const EdgeInsets.all(15.0),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: selectedItem.image == '' ? widget.icon : Image(image: NetworkImage(selectedItem.image)),
                      ),
                    ),
                    suffixIcon: Icon(isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.textFieldDefaultFocus,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.secondaryTextColor,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.alertColor,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.textFieldDefaultBorderColor,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                ),
              ),
            ),
            if (isOpen)
              SizedBox(
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    decoration: BoxDecoration(color: AppColors.grayColor, borderRadius: BorderRadius.circular(15.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(
                        itemExtent: 30,
                        primary: true,
                        shrinkWrap: true,
                        children: widget.list
                            .map((e) => Container(
                                decoration: BoxDecoration(
                                  color: selectedItem.id == e.id ? AppColors.secondaryTextColor : AppColors.grayColor,
                                  borderRadius: selectedItem.id == e.id ? BorderRadius.circular(5) : BorderRadius.circular(0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                      onTap: () {
                                        selectedItem = e;
                                        widget.controller.text = e.name;
                                        isOpen = !isOpen;
                                        widget.onWidgetChanged(selectedItem);
                                        setState(() {});
                                      },
                                      child: Row(children: [
                                        e.image == ''
                                            ? const SizedBox(
                                                height: 30,
                                                width: 30,
                                                child: Icon(
                                                  Icons.reduce_capacity,
                                                  size: 20,
                                                ))
                                            : Image(
                                                image: NetworkImage(e.image),
                                                width: 30,
                                                height: 30,
                                              ),
                                        20.pw,
                                        Text(
                                          e.name,
                                          style: TextStyle(fontSize: e.name.length > 50 ? 10 : 12),
                                        ),
                                        Visibility(visible: false, child: Text(e.id.toString())),
                                      ])),
                                )))
                            .toList(),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
