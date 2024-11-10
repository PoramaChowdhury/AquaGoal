
import 'package:aquagoal/ui/widgets/water_track.dart';
import 'package:flutter/material.dart';

class WaterTrackListView extends StatelessWidget {
  final List<WaterTrack> waterTrackList;
  final Function(int) onDeleteWaterTrack;

  const WaterTrackListView({
    required this.waterTrackList,
    required this.onDeleteWaterTrack,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: waterTrackList.length,
      itemBuilder: (context, index) {
        final waterTrack = waterTrackList[index];
        return ListTile(
          title: Text('${waterTrack.dateTime.hour}:${waterTrack.dateTime.minute}'),
          subtitle: Text(
              '${waterTrack.dateTime.day}/${waterTrack.dateTime.month}/${waterTrack.dateTime.year}'),
          leading: CircleAvatar(
            backgroundColor: Colors.blueAccent,
            child: Text(
              '${waterTrack.noOfGlasses}',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          trailing: IconButton(
            onPressed: () => onDeleteWaterTrack(index),
            icon: const Icon(
              Icons.delete,
              color: Colors.grey,
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
    );
  }
}
