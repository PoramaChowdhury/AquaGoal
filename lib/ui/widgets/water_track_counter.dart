import 'package:flutter/material.dart';

class WaterTrackCounter extends StatelessWidget {
  final TextEditingController glassNoTEController;
  final Function(int) onAddWaterTrack;
  final VoidCallback onReset;

  const WaterTrackCounter({
    required this.glassNoTEController,
    required this.onAddWaterTrack,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Total Glasses', // Placeholder for total count in HomeScreen
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.w600, color: Colors.teal
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 50,
              child: TextField(
                controller: glassNoTEController,
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
                onPressed: () {
                  final int noOfGlasses = int.tryParse(glassNoTEController.text) ?? 1;
                  onAddWaterTrack(noOfGlasses);
                },
                child: const Text(
                  'Add',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: onReset,
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
}
