import 'package:aquagoal/ui/controllers/goal_manager.dart';
import 'package:aquagoal/ui/controllers/water_track_controller.dart';
import 'package:aquagoal/ui/widgets/water_track_counter.dart';
import 'package:aquagoal/ui/widgets/water_track_list_view.dart';
import 'package:flutter/material.dart';
import 'package:aquagoal/ui/screens/settings_screen.dart';
import 'package:aquagoal/ui/screens/reminders_screen.dart';
import 'package:aquagoal/ui/widgets/tm_app_bar.dart';
import 'package:aquagoal/ui/widgets/water_progress_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WaterTrackController _waterTrackController = WaterTrackController();
  final GoalManager _goalManager = GoalManager();
  final TextEditingController _glassNoTEController =
      TextEditingController(text: '1');
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadGoal();
  }
  _loadGoal() async {
    await _goalManager.loadGoal();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TMAppBar(isProfileScreenOpen: false, height: 120),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            WaterTrackCounter(
              glassNoTEController: _glassNoTEController,
              onAddWaterTrack: _onAddWaterTrack,
              onReset: _onResetWaterTrack,
            ),
            const SizedBox(height: 24),
            WaterProgressBar(
                waterTrackList: _waterTrackController.waterTrackList,
                goal: _goalManager.goal),
            const SizedBox(height: 24),
            Expanded(
              child: WaterTrackListView(
                waterTrackList: _waterTrackController.waterTrackList,
                onDeleteWaterTrack: _onDeleteWaterTrack,
              ),
            ),
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
    );
  }

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
        setState(() {
          _goalManager.goal = updatedGoal;
        });
      }
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const RemindersScreen()),
      );
    }
  }

  void _onAddWaterTrack(int noOfGlasses) {
    setState(() {
      _waterTrackController.addWaterTrack(noOfGlasses);
    });
  }

  void _onDeleteWaterTrack(int index) {
    setState(() {
      _waterTrackController.deleteWaterTrack(index);
    });
  }

  void _onResetWaterTrack() {
    setState(() {
      _waterTrackController.resetWaterTrack();
    });
  }
}
