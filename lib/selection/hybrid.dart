import 'package:flutter/material.dart';
import 'package:bitfit102/screens/services/database.dart';
import 'package:bitfit102/shared/constants.dart';
import 'package:bitfit102/selection/calendar.dart';
import 'package:flutter/services.dart';

class HybridPage extends StatefulWidget {
  final String userId;
  final String? selectedGoal;

  const HybridPage({
    Key? key,
    required this.userId,
    required this.selectedGoal,
  }) : super(key: key);

  @override
  _HybridPageState createState() => _HybridPageState();
}

class _HybridPageState extends State<HybridPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController benchPressController = TextEditingController();
  final TextEditingController squatController = TextEditingController();
  final TextEditingController deadliftController = TextEditingController();

  String targetDistance = '2.4km';
  String fitnessLevel = 'Beginner'; // Default value
  bool isNameEmpty = false; // Track whether the name field is empty

  @override
  void dispose() {
    nameController.dispose();
    benchPressController.dispose();
    squatController.dispose();
    deadliftController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Training Details'),
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
              if (isNameEmpty)
                // Display an error message if the name is empty
                const Text(
                  'Please enter your name',
                  style: TextStyle(color: Colors.red),
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
                TextFormField(
                  controller: benchPressController,
                  decoration: textInputDecoration.copyWith(
                      labelText: '1RM Bench Press Target'),
                  keyboardType: TextInputType.number, // Set keyboard type to number
                  inputFormatters: [
                   FilteringTextInputFormatter.digitsOnly
                ],
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: squatController,
                  decoration: textInputDecoration.copyWith(
                      labelText: '1RM Squat Target'),
                  keyboardType: TextInputType.number, // Set keyboard type to number
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: deadliftController,
                  decoration: textInputDecoration.copyWith(
                      labelText: '1RM Max Deadlift Target'),
                  keyboardType: TextInputType.number, // Set keyboard type to number
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly
                  ],
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
              ElevatedButton(
                onPressed: () {
                  String name = nameController.text.trim();
                  double benchPressTarget =
                      double.parse(benchPressController.text.trim());
                  double squatTarget =
                      double.parse(squatController.text.trim());
                  double deadliftTarget =
                      double.parse(deadliftController.text.trim());

                  if (name.isEmpty) {
                    setState(() {
                      isNameEmpty = true;
                    });
                  } else {
                    setState(() {
                      isNameEmpty = false;
                    });

                    DatabaseService(uid: widget.userId).updateLifterUserData(
                      name,
                      fitnessLevel,
                      benchPressTarget,
                      squatTarget,
                      deadliftTarget,
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CalendarPage(
                          targetDistance: targetDistance,
                          benchPressTarget: benchPressTarget,
                          squatTarget: squatTarget,
                          deadliftTarget: deadliftTarget,
                          selectedGoal: widget.selectedGoal,
                        ),
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

