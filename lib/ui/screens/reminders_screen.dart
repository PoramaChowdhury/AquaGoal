import 'package:aquagoal/ui/widgets/reminder_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RemindersScreen extends StatefulWidget {
  const RemindersScreen({super.key});

  @override
  State<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  List<Map<String, dynamic>> reminders = [];

  bool areRemindersOn = true;

  final TextEditingController _reminderTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.red.shade200,
                Colors.purpleAccent.shade100,
              ],
            ),
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.elliptical(25, 25),
            ),
          ),
        ),
        title: const Text(
          'Reminder Screen',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*Flexible(
              child: SwitchListTile(
                title: Text(
                  'Reminders On/Off',
                  style: GoogleFonts.italiana(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                    letterSpacing: 0.5,
                  ),
                ),
                value: areRemindersOn,
                onChanged: (bool value) {
                  setState(() {
                    areRemindersOn = value;
                  });
                },
              ),
            ),*/
            Flexible(
              child: SwitchListTile(
                title: RichText(
                  text: TextSpan(
                    style: GoogleFonts.italiana(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 22,
                      letterSpacing: 0.5,
                    ),
                    children: [
                      const TextSpan(
                        text: 'Reminders ',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: areRemindersOn ? 'ON' : 'OFF',
                        style: TextStyle(
                          color: areRemindersOn ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                value: areRemindersOn,
                onChanged: (bool value) {
                  setState(() {
                    areRemindersOn = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _reminderTEController,
              decoration: const InputDecoration(
                labelText: 'Enter a reminder',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _selectDateTime(context),
              child: const Text('Set Date & Time for Reminder',
                  style: TextStyle(fontSize: 17)),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: reminders.length,
                itemBuilder: (context, index) {
                  final reminder = reminders[index];
                  return ReminderTile(
                    reminderText: reminder['text'],
                    reminderDateTime: reminder['dateTime'],
                    onDelete: () => _deleteReminder(index),
                    onEdit: () => _editReminder(index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addReminder(DateTime selectedTime) {
    final String reminderText = _reminderTEController.text.trim();
    if (reminderText.isNotEmpty && selectedTime != null) {
      setState(() {
        reminders.add({
          'text': reminderText,
          'dateTime': selectedTime,
        });
      });
      _reminderTEController.clear();
    }
  }

  void _deleteReminder(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this reminder?'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  reminders.removeAt(index);
                });
                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _selectDateTime(BuildContext context) async {
    DateTime selectedDate = DateTime.now();

    DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (date == null) return;

    // Time Picker
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDate),
    );

    if (time == null) return;
    selectedDate =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);

    _addReminder(selectedDate);
  }

  void _editReminder(int index) async {
    String? editedText = await showDialog<String>(
      context: context,
      builder: (context) {
        TextEditingController controller =
            TextEditingController(text: reminders[index]['text']);
        return AlertDialog(
          title: const Text('Edit Reminder'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(labelText: 'Reminder text'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(controller.text);
              },
              child: const Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Cancel
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );

    if (editedText != null && editedText.isNotEmpty) {
      setState(() {
        reminders[index]['text'] = editedText;
      });
    }
  }
}
