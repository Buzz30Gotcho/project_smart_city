import 'dart:convert';

import 'package:flutter/material.dart';

class WorkingTime {
  String option;
  List<TimeRange>? fixedHours;
  Map<String, List<TimeRange>>? customizedHours;

  WorkingTime({
    required this.option,
    this.fixedHours,
    this.customizedHours,
  });

  factory WorkingTime.fromJson(Map<String, dynamic> json) {
    final option = json['option'];
    final fixedHoursData = json['fixedHours'] as List<dynamic>? ?? [];
    final customizedHoursData =
        json['customizedHours'] as Map<String, dynamic>? ?? {};

    final fixedHours = fixedHoursData.map<TimeRange>((range) {
      return TimeRange.fromJson(range);
    }).toList();

    final customizedHours =
        customizedHoursData.map<String, List<TimeRange>>((key, value) {
      final ranges = (value as List<dynamic>).map<TimeRange>((range) {
        return TimeRange.fromJson(range);
      }).toList();
      return MapEntry(key, ranges);
    });

    return WorkingTime(
      option: option,
      fixedHours: fixedHours.isNotEmpty ? fixedHours : null,
      customizedHours: customizedHours.isNotEmpty ? customizedHours : null,
    );
  }

  String toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    final fixedHoursData = fixedHours?.map<Map<String, dynamic>>((range) {
      return range.toJson();
    }).toList();

    final customizedHoursData =
        customizedHours?.map<String, List<Map<String, dynamic>>>((key, value) {
      final ranges = value.map<Map<String, dynamic>>((range) {
        return range.toJson();
      }).toList();
      return MapEntry(key.toString().split('.').last, ranges);
    });
    data["option"] = option;
    data["fixedHours"] = fixedHoursData;
    data["customizedHours"] = customizedHoursData;

    return json.encode(data);
  }
}

class TimeRange {
  TimeOfDay? openTime;
  TimeOfDay? closeTime;

  TimeRange({
    required this.openTime,
    required this.closeTime,
  });

  factory TimeRange.fromJson(Map<String, dynamic> json) {
    List<String> openTimeParts = json['openTime'].split(':');
    TimeOfDay openParsedTime = TimeOfDay(
        hour: int.parse(openTimeParts[0]), minute: int.parse(openTimeParts[1]));
    List<String> closeTimeParts = json['closeTime'].split(':');
    TimeOfDay closeParsedTime = TimeOfDay(
        hour: int.parse(closeTimeParts[0]),
        minute: int.parse(closeTimeParts[1]));
    return TimeRange(
        openTime:
            openParsedTime, // TimeOfDay.fromDateTime(DateTime.parse(json['openTime'])),
        closeTime: closeParsedTime
//TimeOfDay.fromDateTime(DateTime.parse(json['closeTime'])),
        );
  }

  Map<String, dynamic> toJson() {
    return {
      'openTime':
          '${openTime!.hour}:${openTime!.minute.toString().padLeft(2, '0')}',
      'closeTime':
          '${closeTime!.hour}:${closeTime!.minute.toString().padLeft(2, '0')}',
    };
  }
}
