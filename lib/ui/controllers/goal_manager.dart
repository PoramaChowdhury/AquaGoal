
import 'package:shared_preferences/shared_preferences.dart';

class GoalManager {
  int goal = 8; // Default goal value

  // Method to load the goal from SharedPreferences
  Future<void> loadGoal() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    goal = prefs.getInt('goal') ?? 8;  // Retrieve goal as an integer
  }

  // Method to save goal to SharedPreferences
  Future<void> saveGoal(int newGoal) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('goal', newGoal);
  }
}
