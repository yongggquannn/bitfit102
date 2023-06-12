import 'package:flutter/material.dart';
import 'package:bitfit102/screens/services/database.dart';
import 'package:bitfit102/shared/constants.dart';
import "package:bitfit102/selection/run_plan.dart";

class RunningPage extends StatefulWidget {
  final String userId;

  const RunningPage({required this.userId});

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
                items: <DropdownMenuItem<String>>[
                  DropdownMenuItem<String>(
                    value: 'Beginner',
                    child: const Text('Beginner'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Intermediate',
                    child: const Text('Intermediate'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Advanced',
                    child: const Text('Advanced'),
                  ),
                ],
                decoration: textInputDecoration.copyWith(labelText: 'Fitness Level'),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: targetDistance,
                onChanged: (value) {
                  setState(() {
                    targetDistance = value!;
                  });
                },
                items: <DropdownMenuItem<String>>[
                  DropdownMenuItem<String>(
                    value: '2.4km',
                    child: const Text('2.4km'),
                  ),
                  DropdownMenuItem<String>(
                    value: '5km',
                    child: const Text('5km'),
                  ),
                  DropdownMenuItem<String>(
                    value: '10km',
                    child: const Text('10km'),
                  ),
                  DropdownMenuItem<String>(
                    value: '21km',
                    child: const Text('21km'),
                  ),
                  DropdownMenuItem<String>(
                    value: '42km',
                    child: const Text('42km'),
                  ),
                ],
                decoration: textInputDecoration.copyWith(labelText: 'Target Distance'),
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
          builder: (context) => RunPlanPage(targetDistance: targetDistance),
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


