import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_client/domain/product_repository/product_repository.dart';
import 'package:proximity_client/domain/product_repository/src/product_service.dart';

class ProductVariantCharacteristics extends StatelessWidget {
  const ProductVariantCharacteristics({Key? key, required this.characteristics})
      : super(key: key);

  final Map<String, List<String>> characteristics;

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);
    final selectedOptions = productService.selectedOptions;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: normal_100),
      child: MasonryGrid(
        column: 1,
        padding: const EdgeInsets.symmetric(horizontal: small_100),
        children: List.generate(
          characteristics.length,
          (index) {
            String key = characteristics.keys.elementAt(index);
            List<String> values = characteristics.values.elementAt(index);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(key), // Display the key in a Text widget
                const SizedBox(height: 10), // Add some spacing
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: GroupedChoiceChip(
                    values: values,
                    selectedValue: selectedOptions![key],
                    onSelected: (selectedValue) {
                      productService.addFilter(key, selectedValue);
                    },
                    onInselected: () {
                      productService.deleteFilter(key);
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class GroupedChoiceChip extends StatelessWidget {
  final List<String> values;
  final String? selectedValue;
  final Function(String) onSelected;
  final Function onInselected;

  const GroupedChoiceChip(
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
      runSpacing: 4.0,
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
