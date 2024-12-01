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

  int goal = 8;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  _loadSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _weightController.text = prefs.getString('weight') ?? '';
      _gender = prefs.getString('gender') ?? 'Male';

      goal =
          prefs.getInt('goal') ?? 8; // Retrieve as int, default to 8 if not set
    });
  }

  _saveSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int goal = int.tryParse(_goalController.text) ?? 8;

    await prefs.setInt('goal', goal);
    await prefs.setString('weight', _weightController.text);
    await prefs.setString('gender', _gender);

    Navigator.pop(context, goal);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Settings saved!')),
    );
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
                  Colors.blue.shade200,
                  Colors.lightBlue.shade400
                ],
              ),
              borderRadius: const BorderRadius.vertical(
                  bottom: Radius.elliptical(25, 25))),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
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
                decoration: const InputDecoration(
                    labelText: 'Water Intake Goal (glasses)'),
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
                      value: gender, child: Text(gender));
                }).toList(),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveSettings,
                child: const Text('Save Settings',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _goalController = TextEditingController();
  int _age = 25;
  int _weight = 60;
  int _height = 170;
  String _gender = 'Male';
  TimeOfDay _wakeUpTime = const TimeOfDay(hour: 7, minute: 0);
  TimeOfDay _sleepTime = const TimeOfDay(hour: 22, minute: 0);

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _age = prefs.getInt('age') ?? 25;
      _weight = prefs.getInt('weight') ?? 60;
      _height = prefs.getInt('height') ?? 170;
      _gender = prefs.getString('gender') ?? 'Male';
      _goalController.text = (prefs.getInt('goal') ?? 8).toString();  // Default goal: 8
      _wakeUpTime = TimeOfDay(
        hour: prefs.getInt('wakeUpHour') ?? 7,
        minute: prefs.getInt('wakeUpMinute') ?? 0,
      );
      _sleepTime = TimeOfDay(
        hour: prefs.getInt('sleepHour') ?? 22,
        minute: prefs.getInt('sleepMinute') ?? 0,
      );
    });
  }

  Future<void> _saveSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('age', _age);
    await prefs.setInt('weight', _weight);
    await prefs.setInt('height', _height);
    await prefs.setString('gender', _gender);
    await prefs.setInt('goal', int.parse(_goalController.text)); // Save goal
    await prefs.setInt('wakeUpHour', _wakeUpTime.hour);
    await prefs.setInt('wakeUpMinute', _wakeUpTime.minute);
    await prefs.setInt('sleepHour', _sleepTime.hour);
    await prefs.setInt('sleepMinute', _sleepTime.minute);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Settings saved!')),
    );
    Navigator.pop(context, int.parse(_goalController.text)); // Return the goal
  }

  Future<void> _selectTime(BuildContext context, bool isWakeUp) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isWakeUp ? _wakeUpTime : _sleepTime,
    );
    if (picked != null) {
      setState(() {
        if (isWakeUp) {
          _wakeUpTime = picked;
        } else {
          _sleepTime = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'What is your gender?',
              style: GoogleFonts.lato(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _genderButton('Male', Icons.male),
                _genderButton('Female', Icons.female),
              ],
            ),
            const SizedBox(height: 24),
            _sliderTile(
              'How old are you?',
              _age,
              0,
              100,
              (value) {
                setState(() => _age = value.toInt());
              },
            ),
            _sliderTile('What is your weight (in kg)?', _weight, 0, 200,
                (value) {
              setState(() => _weight = value.toInt());
            }),
            _sliderTile('What is your height (in cm)?', _height, 0, 200,
                (value) {
              setState(() => _height = value.toInt());
            }),
            const SizedBox(height: 16),
            TextFormField(
              controller: _goalController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  labelText: 'Water Intake Goal (glasses)'),
            ),
            const SizedBox(height: 24),
            _timePickerTile(
              context,
              'Wake up time',
              _wakeUpTime,
              () => _selectTime(context, true),
            ),
            _timePickerTile(
              context,
              'Sleeping time',
              _sleepTime,
              () => _selectTime(context, false),
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: _saveSettings,
                child: const Text('Save Settings'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _genderButton(String gender, IconData icon) {
    return GestureDetector(
      onTap: () => setState(() => _gender = gender),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: _gender == gender ? Colors.blue : Colors.grey[300],
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(height: 4),
          Text(gender),
        ],
      ),
    );
  }

  Widget _sliderTile(String title, int value, double min, double max,
      Function(double) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.lato(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        Slider(
          activeColor: Colors.lightBlueAccent,
          value: value.toDouble(),
          min: min,
          max: max,
          divisions: (max - min).toInt(),
          label: value.toString(),
          onChanged: onChanged,
          thumbColor: Colors.white,
        ),
      ],
    );
  }

  Widget _timePickerTile(
      BuildContext context, String title, TimeOfDay time, VoidCallback onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.lato(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        TextButton(
          onPressed: onTap,
          child: Text('${time.format(context)}'),
        ),
      ],
    );
  }
}
