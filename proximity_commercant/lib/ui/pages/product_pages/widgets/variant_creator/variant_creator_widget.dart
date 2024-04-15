import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proximity/config/config.dart';
import 'package:proximity_commercant/domain/product_repository/product_repository.dart';
import 'package:proximity_commercant/ui/pages/product_pages/view/product_variant_creation_screen.dart';

import 'variant_card.dart';
import 'variant_adder_card.dart';

class VariantCreator extends StatefulWidget {
  const VariantCreator(
      {Key? key,
      this.maxVariants = 0,
      required this.productVariants,
      required this.characteristics,
      required this.onVariantAdded,
      required this.onVariantRemoved})
      : super(key: key);

  final int maxVariants;
  final List<ProductVariant> productVariants;
  final Map<String, Set<String>> characteristics;
  final ValueChanged<ProductVariant> onVariantAdded;
  final ValueChanged<int> onVariantRemoved;

  @override
  _VariantCreatorState createState() => _VariantCreatorState();
}

class _VariantCreatorState extends State<VariantCreator> {
  // Select an image from either the gallery or the camera
  Future<void> _pickImage(ImageSource source) async {
    // ImagePicker _picker = ImagePicker();
    // XFile? _selected = await _picker.pickImage(source: source);
    // if (_selected != null) {
    //   setState(() {
    //     _images.add(File(_selected.path));
    //     widget.onImageAdded.call(_images);
    //   });
    // }
  }

  // Remove an image
  void _removeVariant(int index) {
    setState(() {
      widget.onVariantRemoved.call(index);
    });
  }

  List<Widget> _gridBuilder(List<ProductVariant> variants) {
    List<Widget> _list = [];
    for (int i = 0; i < variants.length; i++) {
      _list.add(
          VariantCard(context, image: variants[i].image, removeVariant: () {
        _removeVariant(i);
      }));
    }
    if (widget.maxVariants > variants.length) {
      _list.add(VariantAdderCard(context, onPressed: () async {
        final ProductVariant? newProductVariant = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductVariantCreationScreen(
                        characteristics: widget.characteristics)))
            as ProductVariant?;
        if (newProductVariant != null) {
          setState(() {
            widget.onVariantAdded.call(newProductVariant);
          });
        }
      }));
    }
    return _list;
  }

  @override
  void initState() {
    super.initState();
    // if (!(widget.images == null) || !(widget.images == [])) {
    //   _images.addAll(widget.images!);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(normal_100),
        child: Wrap(
            spacing: normal_100,
            runSpacing: normal_100,
            alignment: WrapAlignment.start,
            children: _gridBuilder(widget.productVariants)));
  }
}
