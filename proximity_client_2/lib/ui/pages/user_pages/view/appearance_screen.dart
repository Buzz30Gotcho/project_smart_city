import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_client/domain/user_repository/user_repository.dart';
/*
Vue dans le profile , dans la categorie Appearance 
Trois boutons sont affichés :
Le premier bouton est lié au thème du dispositif (probablement par défaut).
Le deuxième bouton permet de passer en mode clair (Light Mode).
Le troisième bouton permet de passer en mode sombre (Dark Mode).
 */
class AppearanceScreen extends StatelessWidget {
  const AppearanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserSettings userSettings = Provider.of<UserSettings>(context);
    return Scaffold(
        body: SafeArea(
            child: ListView(children: [
      const TopBar(title: 'Appearance.'),
      ListButton(
        leadIcon: ProximityIcons.settings,
        title: 'Device Theme',
        onPressed: (userSettings.theme == '')
            ? null
            : () => userSettings.changeTheme(''),
      ),
      ListButton(
        leadIcon: ProximityIcons.light_theme,
        title: 'Light Mode',
        onPressed: (userSettings.theme == 'light')
            ? null
            : () => userSettings.changeTheme('light'),
      ),
      ListButton(
        leadIcon: ProximityIcons.dark_theme,
        title: 'Dark Mode',
        onPressed: (userSettings.theme == 'dark')
            ? null
            : () => userSettings.changeTheme('dark'),//darkTheme
      )
    ])));
  }
}




