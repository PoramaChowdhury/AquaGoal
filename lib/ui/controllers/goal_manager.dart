
import 'package:shared_preferences/shared_preferences.dart';

class GoalManager {
  int goal = 8;


  Future<void> loadGoal() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    goal = prefs.getInt('goal') ?? 8;
  }

  Future<void> saveGoal(int newGoal) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('goal', newGoal);
  }
}
