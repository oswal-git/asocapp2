// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class EglSliderButton extends StatelessWidget {
  const EglSliderButton({
    super.key,
    required this.onChanged,
    this.sliderValue = 0.0,
    this.sliderValueMin = 0.0,
    this.sliderValueMax = 1.0,
  });

  final double sliderValueMin;
  final double sliderValueMax;
  final double sliderValue;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: sliderValue,
      min: sliderValueMin,
      max: sliderValueMin,
      onChanged: (value) => onChanged(value),
    );
  }
}
