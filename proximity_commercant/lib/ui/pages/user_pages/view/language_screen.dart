import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_commercant/domain/user_repository/user_repository.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userSettings = Provider.of<UserSettings>(context);
    return Scaffold(
        body: SafeArea(
            child: ListView(children: [
      const TopBar(title: 'Language'),
      ...(() {
        List<ListButton> _list = <ListButton>[];
        for (var locale in locales) {
          _list.add(ListButton(
            title: languages[locale.languageCode]!,
            leadImage: 'assets/img/${locale.languageCode}.png',
            onPressed: (userSettings.locale == locale)
                ? null
                : () => userSettings.changeLocale(locale),
          ));
        }
        return _list;
      }()),
    ])));
  }
}
