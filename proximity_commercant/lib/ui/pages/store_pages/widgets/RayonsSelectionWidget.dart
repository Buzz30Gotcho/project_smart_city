import 'dart:io';
import 'package:provider/provider.dart';
import 'package:proximity/proximity.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:proximity_commercant/domain/store_repository/store_repository.dart';

class StoreRayonSelectionWidget extends StatefulWidget {
  StoreRayonSelectionWidget({Key? key, this.check_deselect}) : super(key: key);
  bool? check_deselect;
  @override
  _StoreRayonSelectionWidgetState createState() =>
      _StoreRayonSelectionWidgetState();
}

class _StoreRayonSelectionWidgetState extends State<StoreRayonSelectionWidget> {
  List<StoreCategory> categories = [
    // Add more categories and subcategories as needed
  ];
  bool fetched = false;

  TextEditingController rayonController = TextEditingController();
  TextEditingController subStoreCategoryController = TextEditingController();

  @override
  void dispose() {
    rayonController.dispose();
    subStoreCategoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StoreCreationSliderValidation>(
        builder: (context, storeCreationSliderValidation, child) {
      return Column(
        children: [
          ...storeCreationSliderValidation.storeRayons!.map((storeRayon) {
            return CheckboxListTile(
              title: Text(storeRayon.name,
                  style: TextStyle(fontSize: 15.0, color: Color(0xFF000000))),
              value: storeRayon.selected,
              onChanged: (value) {
                setState(() {
                  storeCreationSliderValidation.changeSelectStoreRayons(
                      value, storeRayon.id,
                      check_deselect: widget.check_deselect, context: context);
                });
              },
            );
          }),
          _buildNewStoreCategoryField(storeCreationSliderValidation),
        ],
      );
    });
  }

  Widget _buildNewStoreCategoryField(
      StoreCreationSliderValidation storeCreationSliderValidation) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: EditText(
              controller: rayonController,
              hintText: 'New Store Rayon.',
              suffixIcon: ProximityIcons.add,
              suffixOnPressed: () {
                final rayonName = rayonController.text.trim();
                if (rayonName.isNotEmpty) {
                  storeCreationSliderValidation.addStoreRayon(rayonName);
                  setState(() {
                    rayonController.clear();
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
