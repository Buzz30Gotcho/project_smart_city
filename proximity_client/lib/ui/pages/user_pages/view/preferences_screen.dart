import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_client/domain/user_repository/user_repository.dart';

class PreferencesScreen extends StatelessWidget {
  const PreferencesScreen({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PreferencesValidation>(
        create: (_) => PreferencesValidation.setUserPreferences(user),
        child: Consumer<PreferencesValidation>(
            builder: (_, preferencesValidation, __) {
          return Scaffold(
              body: SafeArea(
                  child: Stack(alignment: Alignment.bottomCenter, children: [
            ListView(children: [
              const TopBar(title: 'Preferences.'),
              SlideSelector(
                  title: 'Proximity Range.',
                  value: preferencesValidation.proximityRange,
                  onChanged: preferencesValidation.changeProximityRange),
              const InfoMessage(
                  message:
                      'Set the Search Diameter in kilometers to provide the...'),
              SectionDivider(
                  leadIcon: Icons.discount_outlined,
                  title: 'Preferred Tags.',
                  color: redSwatch.shade400),
              AdderEditText(
                  hintText: 'Add your preferences here.',
                  onChanged: preferencesValidation.onChangeTagValue,
                  onPressed: preferencesValidation.tagValue.isNotEmpty
                      ? preferencesValidation.addTag
                      : null),
              if (preferencesValidation.preferredTags.isNotEmpty)
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: small_100),
                    child: Wrap(
                        spacing: small_100,
                        runSpacing: 0,
                        children: preferencesValidation.preferredTags
                            .map((item) => Chip(
                                onDeleted: () {
                                  preferencesValidation.removeTag(item);
                                },
                                label: Text(item,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium)))
                            .toList())),
              const SizedBox(height: huge_100)
            ]),
            Consumer<UserService>(builder: (_, userService, __) {
              return BottomActionsBar(buttons: [
                PrimaryButton(
                    onPressed: () {
                      // userService.updateUser(
                      //     context, preferencesValidation.toDataForm());
                    },
                    buttonState: userService.loading
                        ? ButtonState.loading
                        : ButtonState.enabled,
                    title: 'Update.'),
              ]);
            })
          ])));
        }));
  }
}
