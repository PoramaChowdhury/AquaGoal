import 'package:aquagoal/ui/widgets/tm_app_bar.dart';
import 'package:aquagoal/ui/widgets/water_track.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _glassNoTEController =
      TextEditingController(text: '1');

  List<WaterTrack> waterTrackList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TMAppBar(
        isProfileScreenOpen: false,
        height: 100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildWaterTrackCounter(),
            const SizedBox(height: 24),
            Expanded(
              child: buildWaterTrackListView(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildWaterTrackCounter() {
    return Column(
      children: [
        Text(
          getTotalGlassCount().toString(),
          style: const TextStyle(
              fontSize: 30, fontWeight: FontWeight.w600, color: Colors.teal),
        ),
        const Text(
          'Total Glasses',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 30,
              child: TextField(
                  controller: _glassNoTEController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.all(8),
                  )),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: _onTapAddWaterTrack,
              child: const Text(
                'Add',
                style: TextStyle(color: Colors.blue), // Text color
              ),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
                onPressed: _onTapResetButton,
                child: const Text(
                  'Reset',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                )),
          ],
        ),
      ],
    );
  }

  Widget buildWaterTrackListView() {
    return ListView.separated(
      itemCount: waterTrackList.length,
      itemBuilder: (context, index) {
        final WaterTrack waterTrack = waterTrackList[index];
        return _buildWaterTrackListTile(index);
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
    );
  }

  ListTile _buildWaterTrackListTile(int index) {
    WaterTrack waterTrack = waterTrackList[index];
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
          )),
      trailing: IconButton(
          onPressed: () => _onTapDeleteButton(index),
          icon: const Icon(
            Icons.delete,
            color: Colors.grey,
          )),
    );
  }

  int getTotalGlassCount() {
    int counter = 0;
    for (WaterTrack t in waterTrackList) {
      counter += t.noOfGlasses;
    }
    return counter;
  }

  void _onTapAddWaterTrack() {
    if (_glassNoTEController.text.isEmpty) {
      _glassNoTEController.text = '1';
    }
    final int noOfGlasses = int.tryParse(_glassNoTEController.text) ?? 1;
    WaterTrack waterTrack =
        WaterTrack(noOfGlasses: noOfGlasses, dateTime: DateTime.now());
    waterTrackList.add(waterTrack);
    setState(() {});
  }

  void _onTapDeleteButton(int index) {
    waterTrackList.removeAt(index);
    setState(() {});
  }

  void _onTapResetButton() {
    waterTrackList.clear();
    setState(() {});
  }
}
