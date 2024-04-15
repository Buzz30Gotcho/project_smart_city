import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/l10n/app_localizations.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_commercant/domain/product_repository/product_repository.dart';
import 'package:proximity_commercant/domain/store_repository/store_repository.dart';

class CharacteristicEditScreen extends StatefulWidget {
  const CharacteristicEditScreen({Key? key, required this.characteristics})
      : super(key: key);

  final Map<String, Set<String>> characteristics;

  @override
  State<CharacteristicEditScreen> createState() =>
      _CharacteristicEditScreenState();
}

class _CharacteristicEditScreenState extends State<CharacteristicEditScreen> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return ChangeNotifierProvider<CharacteristicFormsController>(
      create: (context) =>
          CharacteristicFormsController(widget.characteristics),
      child: Consumer<CharacteristicFormsController>(
        builder: (context, characteristicFormsController, child) {
          return Scaffold(
            body: SafeArea(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  ListView(
                    children: [
                      TopBar(title: localizations!.variantsCharacteristic),
                      InfoMessage(
                        message: localizations.characteristicDescription,
                      ),
                      ...characteristicFormsController.characteristics.entries
                          .map((e) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(normal_100)
                                  .copyWith(right: 0),
                              child: Row(
                                children: [
                                  Text(
                                    localizations.optionDialogTitle,
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                  Text(
                                    '${e.key} (${e.value.length})',
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                  const SizedBox(width: small_100),
                                  Expanded(
                                    child: Divider(
                                      height: tiny_50,
                                      thickness: tiny_50,
                                    ),
                                  ),
                                  const SizedBox(width: small_100),
                                  ...[
                                    GestureDetector(
                                      onTap: () {
                                        openOptionDeleteDialog(
                                            context,
                                            e.key,
                                            localizations,
                                            characteristicFormsController);
                                      },
                                      child: const Icon(
                                          Icons.highlight_remove_rounded,
                                          size: normal_150),
                                    ),
                                    const SizedBox(width: normal_100),
                                  ]
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: small_100),
                              child: Wrap(
                                spacing: small_100,
                                runSpacing: 0,
                                children: [
                                  ...e.value
                                      .map((item) => Chip(
                                            label: Text(item,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2),
                                            onDeleted: () {
                                              print('XXXXX ${e.value} $item');
                                              characteristicFormsController
                                                  .removeValue(e.key, item);
                                            },
                                          ))
                                      .toList(),
                                  GestureDetector(
                                    onTap: () {
                                      openValueDialog(
                                          context,
                                          e.key,
                                          characteristicFormsController,
                                          localizations);
                                    },
                                    child: Chip(
                                      label: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            ProximityIcons.add,
                                            size: normal_100,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          const SizedBox(width: small_100),
                                          Text(
                                            localizations.addNewValue,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                      Divider(thickness: tiny_50),
                      Padding(
                        padding: const EdgeInsets.all(normal_100),
                        child: SecondaryButton(
                          onPressed: () {
                            openOptionDialog(context,
                                characteristicFormsController, localizations);
                          },
                          title: localizations.addNewOption,
                        ),
                      ),
                      const SizedBox(height: huge_100),
                    ],
                  ),
                  BottomActionsBar(
                    buttons: [
                      SecondaryButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        title: localizations.cancel,
                      ),
                      PrimaryButton(
                        buttonState: characteristicFormsController.isValid
                            ? ButtonState.enabled
                            : ButtonState.disabled,
                        onPressed: () {
                          Navigator.pop(context,
                              characteristicFormsController.characteristics);
                        },
                        title: localizations.submit,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future openValueDialog(
      BuildContext context,
      String option,
      CharacteristicFormsController characteristicFormController,
      AppLocalizations localizations) {
    String? label;
    switch (option) {
      /*case 'Size':
        label = localizations!.sizeMedium;
        break;
      case 'Color':
        label = localizations.colorBlack;
        break;
      case 'Material':
        label = localizations.materialCotton;
        break;
      case 'Style':
        label = localizations.styleClassic;
        break;
      case 'Other':
        label = '';
        break;*/

      default:
        label = '';
        break;
    }

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(localizations.valueDialogTitle),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return EditText(
              hintText: localizations.valueDialogValueName,
              label: label,
              errorText: characteristicFormController.tempValue.error,
              onChanged: (value) {
                setState(() {
                  characteristicFormController.changeValue(value);
                });
              },
            );
          },
        ),
        actions: [
          TertiaryButton(
            onPressed: () {
              characteristicFormController.addValue(option);
              Navigator.pop(context);
            },
            title: localizations.valueDialogSubmit,
          ),
        ],
      ),
    ).then((val) {
      characteristicFormController.changeValue('');
    });
  }

  Future openOptionDialog(
          BuildContext context,
          CharacteristicFormsController characteristicFormController,
          AppLocalizations localizations) =>
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(localizations.optionDialogTitle),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8).copyWith(right: 0),
                    child: DropDownSelector<String>(
                      hintText: localizations.optionDialogOptionName,
                      onChanged: (value, index) {
                        setState(() {
                          characteristicFormController.changePredifinedOption(
                              value, index);
                        });
                      },
                      borderType: BorderType.middle,
                      items: optionsMap.entries
                          .map((item) => DropdownItem<String>(
                                value: item.value,
                                child: Text(
                                  item.value,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                  characteristicFormController.customOption!
                      ? EditText(
                          hintText: localizations.customOptionName,
                          errorText:
                              characteristicFormController.tempOption.error,
                          onChanged: (value) {
                            setState(() {
                              characteristicFormController.changeOption(value);
                            });
                          },
                        )
                      : Container(),
                ],
              );
            },
          ),
          actions: [
            TertiaryButton(
              onPressed: () {
                characteristicFormController.addOption();
                characteristicFormController.resetCustom();
                Navigator.pop(context);
              },
              title: localizations.optionDialogSubmit,
            ),
          ],
        ),
      ).then((val) {
        characteristicFormController.changeOption('');
      });

  Future openOptionDeleteDialog(
          BuildContext context,
          String option,
          AppLocalizations localizations,
          CharacteristicFormsController characteristicFormController) =>
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(localizations.deleteOptionDialogTitle),
          actions: [
            TertiaryButton(
              onPressed: () {
                Navigator.pop(context);
              },
              title: localizations.cancel,
            ),
            TertiaryButton(
              onPressed: () {
                characteristicFormController.removeOption(option);
                Navigator.pop(context);
              },
              title: localizations.delete,
            ),
          ],
        ),
      ).then((val) {
        characteristicFormController.changeValue('');
      });
}
