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
        flexibleSpace: Container(
          height: 150,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.purpleAccent,
                Colors.indigoAccent.shade100,
              ],
            ),
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.elliptical(25, 25),
            ),
          ),
        ),
        title: const Text(
          'Reminders',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SwitchListTile(
                title: Text(
                  'Reminders On/Off',
                  style: GoogleFonts.italiana(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
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
            ),
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
              child: const Text('Set Date & Time for Reminder', style: TextStyle(fontSize: 17)),
            ),
            const SizedBox(height: 16),

            // List to display all the reminders
            Expanded(
              child: ListView.builder(
                itemCount: reminders.length,
                itemBuilder: (context, index) {
                  DateTime reminderTime = reminders[index]['dateTime'];
                  return ListTile(
                    title: Text(reminders[index]['text']),
                    subtitle: Text(
                      '${reminderTime.day}/${reminderTime.month}/${reminderTime.year} at ${reminderTime.hour}:${reminderTime.minute.toString().padLeft(2, '0')}',
                    ), // Display formatted date and time
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Edit Button
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _editReminder(index), // Edit reminder
                        ),
                        // Delete Button
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteReminder(index), // Delete reminder
                        ),
                      ],
                    ),
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
                  reminders.removeAt(index); // Remove the reminder at that index
                });
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Delete'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog without deleting
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

    // Date Picker
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

    // Now add reminder with selected date and time
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
                Navigator.of(context).pop(); // Cancel
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