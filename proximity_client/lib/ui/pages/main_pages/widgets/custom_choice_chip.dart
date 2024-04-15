import 'package:flutter/material.dart';
import 'package:proximity/config/colors.dart';

class CustomChoiceChip extends StatelessWidget {
  final List<String> values;
  final String? selectedValue;
  final Function(String) onSelected;
  final Function onInselected;

  const CustomChoiceChip(
      {Key? key,
      required this.values,
      required this.selectedValue,
      required this.onSelected,
      required this.onInselected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: values.map((value) {
        return ChoiceChip(
          label: Text(
            value,
            style: TextStyle(
              color: selectedValue == value
                  ? primaryTextLightColor
                  : disabledTextLightColor,
            ),
          ),
          backgroundColor: Colors.white,
          selectedColor: Colors.white,
          selected: selectedValue == value,
          onSelected: (selected) {
            if (selected) {
              onSelected(value);
            } else {
              onInselected();
            }
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: BorderSide(
              color: selectedValue == value
                  ? Colors.blue.shade500
                  : dividerLightColor,
              width: selectedValue == value ? 2.5 : 1.0,
            ),
          ),
        );
      }).toList(),
    );
  }
}
