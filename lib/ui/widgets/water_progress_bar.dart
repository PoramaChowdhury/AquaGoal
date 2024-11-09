import 'package:flutter/material.dart';
import 'package:aquagoal/ui/widgets/water_track.dart';

class WaterProgressBar extends StatelessWidget {
  final List<WaterTrack> waterTrackList;
  final int goal; // Goal should come from settings or user input

  const WaterProgressBar({
    super.key,
    required this.waterTrackList,
    this.goal = 8, // Default goal is 8 glasses if no goal is provided
  });

  @override
  Widget build(BuildContext context) {
    // Calculate the total number of glasses consumed
    final totalGlasses = waterTrackList.fold<int>(0, (sum, item) => sum + item.noOfGlasses);

    // Avoid divide by zero if goal is 0
    final progress = goal > 0 ? totalGlasses / goal : 0.0;

    // Cap the progress at 100% (1.0) for a full circle
    final progressPercentage = progress > 1 ? 1.0 : progress;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Water Intake Progress',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),

        // Circular Progress Bar to represent water intake visually
        Stack(
          alignment: Alignment.center,
          children: [
            // Background Circle
            CircularProgressIndicator(
              value: 1.0,  // This is the full circle (background)
              strokeWidth: 10,
              backgroundColor: Colors.grey.shade300,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent.withOpacity(0.4)),
            ),

            // Foreground Circle (fills based on progress)
            CircularProgressIndicator(
              value: progressPercentage,  // This fills according to the progress
              strokeWidth: 10,
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
            ),

            // Text inside the circle to show total consumed glasses and goal
            Text(
              '$totalGlasses/$goal',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        // Show total glasses consumed and goal
        Text(
          'Consumed: $totalGlasses glasses / Goal: $goal glasses',
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
