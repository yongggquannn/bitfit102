import 'package:flutter/material.dart';
import 'package:bitfit102/screens/services/database.dart';
import 'package:bitfit102/shared/constants.dart';
import 'package:bitfit102/selection/calendar.dart';

class RunningPage extends StatefulWidget {
  final String userId;
  final String? selectedGoal;

  const RunningPage(
      {super.key, required this.userId, required this.selectedGoal});

  @override
  _RunningPageState createState() => _RunningPageState();
}

class _RunningPageState extends State<RunningPage> {
  final TextEditingController nameController = TextEditingController();
  String fitnessLevel = 'Beginner'; // Default value
  String targetDistance = '2.4km'; // Default value
  bool isNameEmpty = false; // Track whether the name field is empty

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Running Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: textInputDecoration.copyWith(labelText: 'Name'),
                maxLength: 20, // Set maximum character limit
              ),
              if (isNameEmpty) // Display an error message if the name is empty
                const Text(
                  'Please enter your name',
                  style: TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: fitnessLevel,
                onChanged: (value) {
                  setState(() {
                    fitnessLevel = value!;
                  });
                },
                items: const <DropdownMenuItem<String>>[
                  DropdownMenuItem<String>(
                    value: 'Beginner',
                    child: Text('Beginner'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Intermediate',
                    child: Text('Intermediate'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Advanced',
                    child: Text('Advanced'),
                  ),
                ],
                decoration:
                    textInputDecoration.copyWith(labelText: 'Fitness Level'),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: targetDistance,
                onChanged: (value) {
                  setState(() {
                    targetDistance = value!;
                  });
                },
                items: const <DropdownMenuItem<String>>[
                  DropdownMenuItem<String>(
                    value: '2.4km',
                    child: Text('2.4km'),
                  ),
                  DropdownMenuItem<String>(
                    value: '5km',
                    child: Text('5km'),
                  ),
                  DropdownMenuItem<String>(
                    value: '10km',
                    child: Text('10km'),
                  ),
                  DropdownMenuItem<String>(
                    value: '21km',
                    child: Text('21km'),
                  ),
                  DropdownMenuItem<String>(
                    value: '42km',
                    child: Text('42km'),
                  ),
                ],
                decoration:
                    textInputDecoration.copyWith(labelText: 'Target Distance'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  String name = nameController.text.trim();

                  if (name.isEmpty) {
                    setState(() {
                      isNameEmpty = true;
                    });
                  } else {
                    setState(() {
                      isNameEmpty = false;
                    });

                    DatabaseService(uid: widget.userId).updateUserData(
                      name,
                      fitnessLevel,
                      targetDistance,
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CalendarPage(
                            targetDistance: targetDistance,
                            benchPressTarget: 0,
                            squatTarget: 0,
                            deadliftTarget: 0,
                            selectedGoal: widget.selectedGoal),
                      ),
                    );
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
