/*import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _goalController = TextEditingController();
  String _gender = 'Male';

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  // Load the saved settings from SharedPreferences
  _loadSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _weightController.text = prefs.getString('weight') ?? '';
      _goalController.text = prefs.getString('goal') ?? '';
      _gender = prefs.getString('gender') ?? 'Male';
    });
  }

  // Save the settings to SharedPreferences
  _saveSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('weight', _weightController.text);
    await prefs.setString('goal', _goalController.text);
    await prefs.setString('gender', _gender);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Settings saved!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          height: 120,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.purpleAccent,
                  Colors.indigoAccent.shade100,
                ],
              ),
              borderRadius: const BorderRadius.vertical(
                  bottom: Radius.elliptical(25, 25)
              )
          ),
        ),
        title: const Text('Settings',style: TextStyle(color: Colors.white),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Weight (kg)'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _goalController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Water Intake Goal (glasses)'),
              ),
              const SizedBox(height: 16),
              DropdownButton<String>(
                value: _gender,
                onChanged: (value) {
                  setState(() {
                    _gender = value!;
                  });
                },
                items: const ['Male', 'Female', 'Other'].map((String gender) {
                  return DropdownMenuItem<String>(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Save settings
                  _saveSettings();
                },
                child: const Text('Save Settings'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _goalController = TextEditingController();
  String _gender = 'Male';

  int goal = 8;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  // Load the saved settings from SharedPreferences
  _loadSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _weightController.text = prefs.getString('weight') ?? '';
      _gender = prefs.getString('gender') ?? 'Male';

      goal = prefs.getInt('goal') ?? 8;  // Retrieve as int, default to 8 if not set
    });
  }


  // Save the settings to SharedPreferences
  _saveSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int goal = int.tryParse(_goalController.text) ?? 8;

    // Save goal as an integer (make sure it's saved as an int)
    await prefs.setInt('goal', goal);
    await prefs.setString('weight', _weightController.text);
    await prefs.setString('gender', _gender);

    // Return the updated goal back to HomeScreen
    Navigator.pop(context, goal);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Settings saved!')),
    );
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          height: 200,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.indigoAccent.shade100,
                  Colors.purpleAccent.shade100,
                ],
              ),
              borderRadius: const BorderRadius.vertical(
                  bottom: Radius.elliptical(25, 25)
              )
          ),
        ),
        title: const Text('Settings',style: TextStyle(color: Colors.white),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Weight (kg)'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _goalController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Water Intake Goal (glasses)'),
              ),
              const SizedBox(height: 16),
              DropdownButton<String>(
                value: _gender,
                onChanged: (value) {
                  setState(() {
                    _gender = value!;
                  });
                },
                items: const ['Male', 'Female', 'Other'].map((String gender) {
                  return DropdownMenuItem<String>(value: gender, child: Text(gender));
                }).toList(),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveSettings,
                child: const Text('Save Settings'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
