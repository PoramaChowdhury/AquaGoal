import 'dart:convert';

class WaterTrack {
  final int noOfGlasses;
  final DateTime dateTime;

  WaterTrack({required this.noOfGlasses, required this.dateTime});

  // Convert a WaterTrack object into a Map object
  Map<String, dynamic> toJson() => {
    'noOfGlasses': noOfGlasses,
    'dateTime': dateTime.toIso8601String(),
  };

  // Extract a WaterTrack object from a Map object
  factory WaterTrack.fromJson(Map<String, dynamic> json) {
    return WaterTrack(
      noOfGlasses: json['noOfGlasses'],
      dateTime: DateTime.parse(json['dateTime']),
    );
  }
}