import 'dart:io';
import 'package:proximity/config/backend.dart';

import 'package:flutter/services.dart';
import 'package:proximity/domain_repository/models/address_model.dart';
import 'package:flutter/services.dart' show Uint8List, rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:proximity_commercant/domain/store_repository/models/models.dart';

class User {
  String? id;
  String? userName;

  String? email;
  String? phone;
  DateTime? birthdate;
  Address? address;
  Address? shippingAddress;
  bool? isVerified;
  bool? welcome;
  List<dynamic>? profileImage;
  Policy? policy;

  User(
      {this.id,
      this.userName,
      this.email,
      this.phone,
      this.birthdate,
      this.address,
      this.shippingAddress,
      this.isVerified,
      this.welcome,
      this.profileImage,
      this.policy});

  User.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['_id'],
        userName = parsedJson['username'],
        email = parsedJson['email'],
        phone = parsedJson['phone'],
        birthdate = DateTime(1999, 7, 8),
        address = parsedJson['adresse'] != null
            ? Address(
                lat: (parsedJson['adresse']['latitude'] ?? 0).toDouble(),
                lng: (parsedJson['adresse']['longitude'] ?? 0).toDouble(),
                city: parsedJson['adresse']['city'],
                fullAddress: parsedJson['adresse']['streetName'],
                streetName: parsedJson['adresse']['apartmentNumber'],
                postalCode: parsedJson['adresse']['postalCode'],
                countryCode: parsedJson['adresse']['countryCode'],
                countryName: parsedJson['adresse']['country'],
                locality: parsedJson['adresse']['region'],
                region: parsedJson['adresse']['region'],
              )
            : null,
        shippingAddress = parsedJson['adresse'] != null &&
                parsedJson['shippingAdress'] != null
            ? Address(
                lat: (parsedJson['adresse']['latitude'] ?? 0).toDouble(),
                lng: (parsedJson['adresse']['longitude'] ?? 0).toDouble(),
                city: parsedJson['shippingAdress']['city'],
                fullAddress: parsedJson['shippingAdress']['streetName'],
                streetName: parsedJson['shippingAdress']['apartmentNumber'],
                postalCode: parsedJson['shippingAdress']['postalCode'],
                countryCode: parsedJson['shippingAdress']['countryCode'],
                countryName: parsedJson['shippingAdress']['country'],
                locality: parsedJson['shippingAdress']['region'],
                region: parsedJson['shippingAdress']['region'],
              )
            : null,
        isVerified = parsedJson['isVerified'] ?? false,
        welcome = parsedJson['welcome'] ?? false,
        profileImage = parsedJson['profileImage'] == null
            ? [null]
            : [BASE_IMG_URL + '/' + parsedJson['profileImage']],
        policy = parsedJson['policy'] == null
            ? parsedJson['policy']
            : Policy.fromJson(parsedJson['policy']);
}
