import 'package:aquagoal/ui/widgets/water_track.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class WaterTrackController {
  List<WaterTrack> waterTrackList = [];

  // Load water tracks from SharedPreferences
  Future<void> loadWaterTracks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('waterTracks');
    if (jsonString != null) {
      List<dynamic> jsonList = json.decode(jsonString);
      waterTrackList = jsonList.map((json) => WaterTrack.fromJson(json)).toList();
    }
  }

  // Save water tracks to SharedPreferences
  Future<void> saveWaterTracks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = json.encode(waterTrackList.map((track) => track.toJson()).toList());
    await prefs.setString('waterTracks', jsonString);
  }

  void addWaterTrack(int noOfGlasses) {
    WaterTrack waterTrack = WaterTrack(noOfGlasses: noOfGlasses, dateTime: DateTime.now());
    waterTrackList.add(waterTrack);
    saveWaterTracks(); // Save after adding
  }

  void deleteWaterTrack(int index) {
    waterTrackList.removeAt(index);
    saveWaterTracks(); // Save after deleting
  }

  void resetWaterTrack() {
    waterTrackList.clear();
    saveWaterTracks(); // Save after resetting
  }

  int getTotalGlassCount() {
    return waterTrackList.fold(0, (sum, track) => sum + track.noOfGlasses);
  }
}