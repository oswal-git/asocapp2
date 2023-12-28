// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asocapp/app/config/config.dart';
import 'package:asocapp/app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class EglCheckboxButton extends StatefulWidget {
  final bool isChecked;
  final ValueChanged<bool> onChanged;
  final double width;
  final double height;
  const EglCheckboxButton({
    super.key,
    this.isChecked = false,
    required this.onChanged,
    this.width = 60.0,
    this.height = 30.0,
  });

  @override
  State<EglCheckboxButton> createState() => _EglCheckboxButtonState();
}

class _EglCheckboxButtonState extends State<EglCheckboxButton> {
  late bool _value;
  late double sizeCircle;
  late double marginCircle;
  late double displacement;

  @override
  void initState() {
    super.initState();
    _value = widget.isChecked;
    marginCircle = 0.17 * widget.height;
    sizeCircle = widget.height - 2 * marginCircle;
    displacement = widget.width - sizeCircle - marginCircle;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _value = !_value;
          widget.onChanged(_value);
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: _value ? Colors.red : Colors.green[700],
          borderRadius: BorderRadius.circular(30),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              left: _value ? displacement : marginCircle,
              top: marginCircle,
              child: EglCircleIconButton(
                color: EglColorsApp.iconColor,
                backgroundColor: EglColorsApp.hint,
                icon: _value ? Icons.edit : Icons.list_alt_outlined, // Cambiar a tu icono correspondiente
                size: sizeCircle - 8,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
