
import 'package:aquagoal/ui/widgets/water_track.dart';

class WaterTrackController {
  List<WaterTrack> waterTrackList = [];

  int getTotalGlassCount() {
    int counter = 0;
    for (WaterTrack t in waterTrackList) {
      counter += t.noOfGlasses;
    }
    return counter;
  }

  void addWaterTrack(int noOfGlasses) {
    WaterTrack waterTrack = WaterTrack(noOfGlasses: noOfGlasses, dateTime: DateTime.now());
    waterTrackList.add(waterTrack);
  }

  void deleteWaterTrack(int index) {
    waterTrackList.removeAt(index);
  }

  void resetWaterTrack() {
    waterTrackList.clear();
  }
}