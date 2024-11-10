/*

import 'package:flutter/material.dart';
import 'package:aquagoal/ui/screens/settings_screen.dart';
import 'package:aquagoal/ui/screens/reminders_screen.dart';
import 'package:aquagoal/ui/widgets/water_progress_bar.dart';
import 'package:aquagoal/ui/widgets/tm_app_bar.dart';
import 'package:aquagoal/ui/widgets/water_track.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _glassNoTEController = TextEditingController(text: '1');
  List<WaterTrack> waterTrackList = [];
  int _currentIndex = 0; // Track the bottom nav bar selected index
  int goal = 8; // Default goal value

  @override
  void initState() {
    super.initState();
    _loadGoal();
  }

  // Load goal from SharedPreferences
  _loadGoal() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      goal = prefs.getInt('goal') ?? 8;  // Retrieve goal as an integer
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TMAppBar(isProfileScreenOpen: false, height: 120),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildWaterTrackCounter(),
            const SizedBox(height: 24),
            WaterProgressBar(waterTrackList: waterTrackList, goal: goal),
            const SizedBox(height: 24),
            Expanded(child: buildWaterTrackListView()), // Wrap ListView with Expanded
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onNavBarTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Reminders',
          ),
        ],
      ),
      // bottomNavigationBar: buildBottomNavigationBar(context),
    );
  }

  // BottomNavigationBar buildBottomNavigationBar(BuildContext context) {
  //   return BottomNavigationBar(
  //     currentIndex: _currentIndex,
  //     onTap: (int index) async {
  //       setState(() {
  //         _currentIndex = index;
  //       });
  //       if (index == 1) {
  //         final updatedGoal = await Navigator.push(
  //           context,
  //           MaterialPageRoute(builder: (context) => const SettingsScreen()),
  //         );
  //
  //         if (updatedGoal != null) {
  //           // Update the goal in HomeScreen when SettingsScreen returns the updated goal
  //           setState(() {
  //             goal = updatedGoal; // Update goal with the new value from SettingsScreen
  //           });
  //         }
  //       } else if (index == 2) {
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(builder: (context) => const RemindersScreen()),
  //         );
  //       }
  //     },
  //     items: const [
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.home),
  //         label: 'Home',
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.settings),
  //         label: 'Settings',
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.notifications),
  //         label: 'Reminders',
  //       ),
  //     ],
  //   );
  // }

  void _onNavBarTapped(int index) async {
    setState(() {
      _currentIndex = index;
    });
    if (index == 1) {
      final updatedGoal = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SettingsScreen()),
      );

      if (updatedGoal != null) {
        // Update the goal in HomeScreen when SettingsScreen returns the updated goal
        setState(() {
          goal = updatedGoal; // Update goal with the new value from SettingsScreen
        });
      }
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const RemindersScreen()),
      );
    }
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
              width: 50,
              child: TextField(
                controller: _glassNoTEController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.all(8),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: _onTapAddWaterTrack,
                child: const Text(
                  'Add',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: _onTapResetButton,
                child: const Text(
                  'Reset',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
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
        return _buildWaterTrackListTile(index, waterTrack);
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
    );
  }

  ListTile _buildWaterTrackListTile(int index, WaterTrack waterTrack) {
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
        onPressed: () => _onTapDeleteButton(index),
        icon: const Icon(
          Icons.delete,
          color: Colors.grey,
        ),
      ),
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



*/