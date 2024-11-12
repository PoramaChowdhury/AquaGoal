// reminder_tile.dart
import 'package:flutter/material.dart';

class ReminderTile extends StatelessWidget {
  final String reminderText;
  final DateTime reminderDateTime;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const ReminderTile({
    super.key,
    required this.reminderText,
    required this.reminderDateTime,
    required this.onDelete,
    required this.onEdit, // Added onEdit callback
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(reminderText),
      subtitle: Text(
        '${reminderDateTime.day}/${reminderDateTime.month}/${reminderDateTime.year} at ${reminderDateTime.hour}:${reminderDateTime.minute.toString().padLeft(2, '0')}',
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min, // Ensures the row only takes up as much space as needed
        children: [
          // Edit Button
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.blue),
            onPressed: onEdit, // Calls the onEdit callback
          ),
          // Delete Button
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: onDelete, // Calls the onDelete callback
          ),
        ],
      ),
    );
  }
}
