import 'package:flutter/material.dart';
import 'package:proximity_client/domain/user_repository/models/models.dart';

class PreferencesValidation with ChangeNotifier {
  late int _proximityRange;
  String _tagValue = "";
  late List<String> _preferredTags;

  PreferencesValidation.setUserPreferences(User user) {
    _proximityRange =  10;
    _preferredTags = [
      'Apple',
      'Smartphones',
      'Camera'
    ];
    notifyListeners();
  }

  // Getters
  int get proximityRange => _proximityRange;

  String get tagValue => _tagValue;

  List<String> get preferredTags => _preferredTags;

  // Setters
  void changeProximityRange(double value) {
    _proximityRange = value.toInt();
    notifyListeners();
  }

  void onChangeTagValue(String value) {
    _tagValue = value;
    notifyListeners();
  }

  void addTag() {
    _preferredTags.add(_tagValue);
    _tagValue = "";
    notifyListeners();
  }

  void removeTag(String value) {
    _preferredTags.remove(value);
    notifyListeners();
  }
}
