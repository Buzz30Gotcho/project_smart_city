import 'dart:io';
import 'package:provider/provider.dart';
import 'package:proximity/proximity.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:proximity_commercant/domain/store_repository/store_repository.dart';

class StoreTemplateSelectionWidget extends StatefulWidget {
  const StoreTemplateSelectionWidget({Key? key}) : super(key: key);

  @override
  _StoreTemplateSelectionWidgetState createState() =>
      _StoreTemplateSelectionWidgetState();
}

class _StoreTemplateSelectionWidgetState
    extends State<StoreTemplateSelectionWidget> {
  TextEditingController categoryController = TextEditingController();
  TextEditingController subStoreCategoryController = TextEditingController();

  @override
  void dispose() {
    categoryController.dispose();
    subStoreCategoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StoreCreationSliderValidation>(
        builder: (context, storeCreationSliderValidation, child) {
      return Column(
        children: [
          ...storeCreationSliderValidation.templates.map((storeTemplate) {
            return CheckboxListTile(
              title: Text(storeTemplate.name,
                  style: TextStyle(fontSize: 15.0, color: Color(0xFF000000))),
              value: storeTemplate.selected,
              onChanged: (value) {
                setState(() {
                  storeCreationSliderValidation.changeSelectStoreTemplate(
                      value, storeTemplate.id);
                });
              },
            );
          }),
        ],
      );
    });
  }
}
