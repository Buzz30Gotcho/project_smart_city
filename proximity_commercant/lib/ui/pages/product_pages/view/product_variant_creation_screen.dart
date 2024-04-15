import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity/widgets/forms/edit_text_spacer.dart';
import 'package:proximity_commercant/domain/product_repository/product_repository.dart';

class ProductVariantCreationScreen extends StatefulWidget {
  const ProductVariantCreationScreen({Key? key, required this.characteristics})
      : super(key: key);

  final Map<String, Set<String>> characteristics;

  @override
  State<ProductVariantCreationScreen> createState() =>
      _ProductVariantCreationScreenState();
}

class _ProductVariantCreationScreenState
    extends State<ProductVariantCreationScreen> {
  late ProductVariant _variant;
  ValidationItem _price = ValidationItem(null, null);
  ValidationItem _quantity = ValidationItem(null, null);

  @override
  void initState() {
    super.initState();
    _variant = ProductVariant(
        characteristics:
            List<dynamic>.filled(widget.characteristics.length, null),
        available: true);
  }

  void changePrice(String value) {
    if (value == '') {
      // _price = ValidationItem(null, null);
    } else {
      bool _priceValid = RegExp(r'^\d+(\.\d{1,3})?$').hasMatch(value);
      if (_priceValid) {
        _price = ValidationItem(value, null);
      } else {
        _price = ValidationItem(null, "● Enter a valid price (e.g., 12.99).");
      }
    }
  }

  /* void changeQuantity(String value) {
    _quantity = int.tryParse(value);
    notifyListeners();
  }*/
  void changeQuantity(String value) {
    if (value == '') {
      _quantity = ValidationItem(null, null);
    } else {
      int? quantity = int.tryParse(value);
      if (quantity != null && quantity > 0) {
        _quantity = ValidationItem(value, null);
      } else {
        _quantity = ValidationItem(null, "● Enter a valid quantity.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(alignment: Alignment.bottomCenter, children: [
      ListView(children: [
        const TopBar(title: "Product Variant."),
        const InfoMessage(
            message:
                "Select below the characteristics of this Variant and pick an image."),
        SectionDivider(
            leadIcon: ProximityIcons.product,
            title: 'Variant Characteristics.',
            color: redSwatch.shade400),
        ...(() {
          List<Widget> _list = [];
          for (int i = 0; i < widget.characteristics.length; i++) {
            _list.add(Padding(
              padding: const EdgeInsets.symmetric(horizontal: normal_100),
              child: DropDownSelector(
                  hintText: widget.characteristics.keys.elementAt(i),
                  padding: true,
                  // savedValue: ,
                  onChanged: (value, index) {
                    setState(() {
                      _variant.characteristics![i] = MapEntry(
                          widget.characteristics.keys.elementAt(i), value);
                    });
                  },
                  items: widget.characteristics.values
                      .elementAt(i)
                      .map((item) => DropdownItem<String>(
                          value: item,
                          child: Text(item,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(fontWeight: FontWeight.w600))))
                      .toList()),
            ));
          }
          return _list;
        }()),
        SectionDivider(
            leadIcon: ProximityIcons.cart,
            title: 'Variant Offer.',
            color: redSwatch.shade400),
        EditText(
            hintText: 'Variant Price in €.',
            borderType: BorderType.middle,
            keyboardType: TextInputType.number,
            errorText: _price.error,
            onChanged: (value) {
              setState(() {
                changePrice(value);
                if (_price.value != null) {
                  _variant.price = double.tryParse(value);
                }

                /*changePrice(value);
              if (_price.value != null) {
                
                setState(() {
                  _variant.price = double.tryParse(value);
                });
              }*/
              });
            }),
        const EditTextSpacer(),
        EditText(
            hintText: 'Variant Quantity.',
            borderType: BorderType.middle,
            keyboardType: TextInputType.number,
            errorText: _quantity.error,
            onChanged: (value) {
              changeQuantity(value);
              if (_quantity != null) {
                setState(() {
                  _variant.quantity = int.tryParse(value);
                });
              }
            }),
        SectionDivider(
            leadIcon: ProximityIcons.picture,
            title: 'Variant Image.',
            color: redSwatch.shade400),
        ImagePickerWidget(
            images: (_variant.image == null) ? [] : [_variant.image],
            maxImages: 1,
            centered: true,
            onImageAdded: (List<dynamic> imageList) {
              setState(() {
                _variant.image = imageList.first;
              });
            },
            onImageRemoved: (int index) {
              setState(() {
                _variant.image = null;
              });
            }),
        const SizedBox(height: huge_100),
      ]),
      BottomActionsBar(buttons: [
        PrimaryButton(
            buttonState:
                _variant.isValid ? ButtonState.enabled : ButtonState.disabled,
            onPressed: () {
              Navigator.pop(context, _variant);
            },
            title: 'Submit.')
      ])
    ])));
  }
}
