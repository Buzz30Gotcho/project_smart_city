import 'package:hive/hive.dart';

class Boxes {
  static Box getCredentials() => Hive.box('credentials');
  static Box getWecome() => Hive.box('welcome');
  static Box getSettingsBox() => Hive.box('settings');
}
