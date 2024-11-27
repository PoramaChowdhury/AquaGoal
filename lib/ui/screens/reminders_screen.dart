
/*import 'package:aquagoal/ui/widgets/reminder_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

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
  void initState() {
    super.initState();

    // Initialize notifications and request permissions if not allowed
    AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelGroupKey: 'basic_channel_group',
          channelKey: 'basic_channel',
          channelName: 'Basic Notifications',
          channelDescription: 'Notification channel for basic reminders',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.white,
        ),
      ],
    );

    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

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
              child: const Text(
                'Set Date & Time for Reminder',
                style: TextStyle(fontSize: 17),
              ),
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
    if (reminderText.isNotEmpty) {
      setState(() {
        reminders.add({
          'text': reminderText,
          'dateTime': selectedTime,
        });
      });

      // Schedule notification for the added reminder
      _scheduleNotification(reminderText, selectedTime);
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

  void _scheduleNotification(String reminderText, DateTime reminderTime) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.remainder(100000), // Unique ID
        channelKey: 'basic_channel',
        title: 'Reminder',
        body: reminderText,
        notificationLayout: NotificationLayout.Default,
      ),
      schedule: NotificationCalendar(
        year: reminderTime.year,
        month: reminderTime.month,
        day: reminderTime.day,
        hour: reminderTime.hour,
        minute: reminderTime.minute,
        second: 0, // Optional, default is 0
        millisecond: 0, // Optional, default is 0
        repeats: false, // Set true if you want recurring notifications
      ),
    );
  }
}*/


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
  void initState() {
    super.initState();
    _loadReminders();

    // Initialize notifications and request permissions if not allowed
    AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelGroupKey: 'basic_channel_group',
          channelKey: 'basic_channel',
          channelName: 'Basic Notifications',
          channelDescription: 'Notification channel for basic reminders',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.white,
        ),
      ],
    );

    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

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
            SwitchListTile(
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
              child: const Text(
                'Set Date & Time for Reminder',
                style: TextStyle(fontSize: 17),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: reminders.length,
                itemBuilder: (context, index) {
                  final reminder = reminders[index];
                  return ListTile(
                    title: Text(reminder['text']),
                    subtitle: Text(reminder['dateTime'].toString()),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _editReminder(index),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteReminder(index),
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

  // Add Reminder
  void _addReminder(DateTime selectedTime) async {
    final String reminderText = _reminderTEController.text.trim();
    if (reminderText.isNotEmpty) {
      setState(() {
        reminders.add({
          'text': reminderText,
          'dateTime': selectedTime,
        });
      });

      // Save to Hive
      final box = await Hive.openBox('remindersBox');
      await box.add({
        'text': reminderText,
        'dateTime': selectedTime.toIso8601String(),
      });

      // Schedule Notification
      _scheduleNotification(reminderText, selectedTime);
    }
  }

  // Edit Reminder
  Future<void> _editReminder(int index) async {
    final box = await Hive.openBox('remindersBox');
    final TextEditingController editController =
    TextEditingController(text: reminders[index]['text']);

    String? editedText = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Reminder'),
          content: TextField(
            controller: editController,
            decoration: const InputDecoration(labelText: 'Reminder text'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(editController.text);
              },
              child: const Text('Save'),
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

    if (editedText != null && editedText.isNotEmpty) {
      setState(() {
        reminders[index]['text'] = editedText;
      });

      // Update Hive
      await box.putAt(index, {
        'text': editedText,
        'dateTime': reminders[index]['dateTime'].toIso8601String(),
      });
    }
  }

  // Delete Reminder
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
                final deletedReminder = reminders[index]; // Store the deleted reminder
                setState(() {
                  reminders.removeAt(index); // Remove the reminder
                });
                Navigator.pop(context); // Close the confirmation dialog

                // Show SnackBar with Undo action
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Reminder deleted'),
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () {
                        setState(() {
                          reminders.insert(index, deletedReminder); // Restore the deleted reminder
                        });
                      },
                    ),
                    duration: const Duration(seconds: 3),
                  ),
                );
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

  // Load Reminders
  Future<void> _loadReminders() async {
    final box = await Hive.openBox('remindersBox');
    final List<Map<String, dynamic>> loadedReminders = [];

    for (var i = 0; i < box.length; i++) {
      final reminder = box.getAt(i);
      loadedReminders.add({
        'text': reminder['text'],
        'dateTime': DateTime.parse(reminder['dateTime']),
      });
    }

    setState(() {
      reminders = loadedReminders;
    });
  }

  // Select Date and Time
  Future<void> _selectDateTime(BuildContext context) async {
    DateTime selectedDate = DateTime.now();

    DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (date == null) return;

    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDate),
    );
    if (time == null) return;

    selectedDate =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);

    _addReminder(selectedDate);
  }

  // Schedule Notification
  void _scheduleNotification(String reminderText, DateTime reminderTime) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
        channelKey: 'basic_channel',
        title: 'Reminder',
        body: reminderText,
        notificationLayout: NotificationLayout.Default,
      ),
      schedule: NotificationCalendar(
        year: reminderTime.year,
        month: reminderTime.month,
        day: reminderTime.day,
        hour: reminderTime.hour,
        minute: reminderTime.minute,
        second: 0,
        repeats: false,
      ),
    );
  }
}




