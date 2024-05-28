import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_client/domain/user_repository/user_repository.dart';

class NotificationSettingsScreen extends StatelessWidget {
  const NotificationSettingsScreen({Key? key, required this.user})
      : super(key: key);

  final User? user;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NotificationSettingsValidation>(
        create: (_) =>
            NotificationSettingsValidation.setUserNotificationsSettings(user),
        child: Consumer2<NotificationSettingsValidation, UserService>(
            builder: (_, preferencesValidation, userService, __) {
          return Scaffold(
              body: SafeArea(
                  child: Stack(alignment: Alignment.bottomCenter, children: [
            ListView(children: [
              const TopBar(title: 'Notifications.'),
              Column(
                children: [
                  const SizedBox(height: normal_100),
                  SectionDivider(
                      leadIcon: Icons.notifications_none_outlined,
                      title: 'Notification Types .',
                      noPadding: true,
                      color: redSwatch.shade500),
                  const InfoMessage(
                      message: 'You can enable or disable notifications'),
                  Padding(
                    padding:
                        const EdgeInsets.all(normal_100).copyWith(right: 0),
                    child: Column(
                      children: [
                        ListToggle(
                            title: 'Order notifications',
                            value: preferencesValidation.notifOrders!,
                            onToggle:
                                preferencesValidation.toggleNotifRealTime),
                        ListToggle(
                            title: 'Offer notifications',
                            value: preferencesValidation.notifOffers!,
                            onToggle: preferencesValidation.toggleNotifHourly),
                      ],
                    ),
                  ),
                  SectionDivider(
                      leadIcon: Icons.notifications_active_outlined,
                      title: 'Notification Options.',
                      noPadding: true,
                      color: redSwatch.shade500),
                  const InfoMessage(
                      message:
                          'Choose how you want to be notified . Select from email, SMS, phone call, or in-platform notifications. Pick your preferred method(s) for convenience.'),
                  Padding(
                    padding: const EdgeInsets.all(normal_100)
                        .copyWith(right: 0, bottom: 100),
                    child: Column(
                      children: [
                        ListToggle(
                            title: 'In-platform notifications',
                            value: preferencesValidation.notifInPlateforme!,
                            onToggle:
                                preferencesValidation.toggleNotifInPlateforme),
                        ListToggle(
                            title: 'Pop pup notifications ',
                            value: preferencesValidation.notifPopUp!,
                            onToggle: preferencesValidation.toggleNotifPopup),
                        ListToggle(
                            title: 'Email notifications',
                            value: preferencesValidation.notifEmail!,
                            onToggle: preferencesValidation.toggleNotifEmail),
                        ListToggle(
                            title: 'SMS notifications',
                            value: preferencesValidation.notifSms!,
                            onToggle: preferencesValidation.toggleNotifSms),
                      ],
                    ),
                  ),
                ],
              ),
            ]),
            BottomActionsBar(buttons: [
              PrimaryButton(
                  onPressed: () {
                    Map<String, dynamic> formdata =
                        preferencesValidation.toFormData();
                    userService.updateUser(context, formdata);
                  },
                  buttonState: preferencesValidation.loading
                      ? ButtonState.loading
                      : ButtonState.enabled,
                  title: 'Update.'),
            ])
          ])));
        }));
  }
}
