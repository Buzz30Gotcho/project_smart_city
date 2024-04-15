import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_commercant/domain/store_repository/store_repository.dart';

import 'package:provider/provider.dart';
import 'package:proximity/widgets/forms/edit_text_spacer.dart';
import 'package:proximity_commercant/domain/store_repository/src/policy_creation_validation.dart';
import 'package:proximity_commercant/domain/user_repository/user_repository.dart';
import 'package:proximity_commercant/ui/pages/home_pages/view/home_screen.dart';
import 'package:proximity_commercant/ui/pages/store_pages/view/store_policy_screen.dart';
import 'package:proximity_commercant/ui/widgets/address_picker/address_picker.dart';
import 'package:proximity_commercant/ui/pages/store_pages/widgets/widgets.dart';

class StoreEditStoreRayonsScreen extends StatefulWidget {
  const StoreEditStoreRayonsScreen({
    Key? key,
    this.index,
    required this.store,
  }) : super(key: key);

  final int? index;
  final Store store;

  @override
  State<StoreEditStoreRayonsScreen> createState() =>
      _StoreEditStoreRayonsScreenState();
}

class _StoreEditStoreRayonsScreenState
    extends State<StoreEditStoreRayonsScreen> {
  final int _currentIndex = 0;

  int index = 0;

  @override
  Widget build(BuildContext context) {
    final policyValidation = Provider.of<PolicyValidation>(context);
    User? _user = context.watch<UserService>().user;

    /// a boolean to help fetch data ONLY if necessary
    bool didFetch = false;

    return ChangeNotifierProvider<StoreCreationSliderValidation>(
        create: (context) =>
            StoreCreationSliderValidation.setStore(widget.store),
        child: Consumer2<StoreCreationSliderValidation, StoreService>(builder:
            (context, storeCreationSliderValidation, storeService, child) {
          if (!didFetch) {
            storeCreationSliderValidation.getStoreRayons();
            didFetch = true;
          }
          return Scaffold(
              body: SafeArea(
                  child: Stack(alignment: Alignment.bottomCenter, children: [
            Column(children: [
              TopBar(title: 'Edit Store Rayons.'),
              Expanded(
                  child: ListView(children: [
                StoreRayonSelectionWidget(check_deselect: true)
              ])),

              /// Store Details
              BottomActionsBar(buttons: [
                PrimaryButton(
                    buttonState: storeService.formsLoading
                        ? ButtonState.loading
                        : (storeCreationSliderValidation.storeRayons!
                                .where((element) => element.selected == true)
                                .isNotEmpty)
                            ? ButtonState.enabled
                            : ButtonState.disabled,
                    onPressed: () {
                      FormData fdUpdate = storeCreationSliderValidation
                          .UpdateStoreRayonsFormData();
                      storeService
                          .editStore(context, widget.index ?? 0, fdUpdate, []);
                    },
                    title: 'Confirm.')
              ])

              /// Image Picker
            ])
          ])));
        }));

    // ));
  }
}
