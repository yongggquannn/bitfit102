import 'package:flutter/material.dart';
import "package:bitfit102/screens/services/database.dart";

class RunningPage extends StatefulWidget {
  //final String userId;

  const RunningPage({super.key });

  @override
  _RunningPageState createState() => _RunningPageState();
}

class _RunningPageState extends State<RunningPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController fitnessLevelController = TextEditingController();
  final TextEditingController targetDistanceController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    fitnessLevelController.dispose();
    targetDistanceController.dispose();
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
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: fitnessLevelController,
                decoration: const InputDecoration(labelText: 'Fitness Level'),
              ),
              TextField(
                controller: targetDistanceController,
                decoration: const InputDecoration(labelText: 'Target Distance'),
              ),
              ElevatedButton(
                onPressed: () {
                  String name = nameController.text;
                  String fitnessLevel = fitnessLevelController.text;
                  String targetDistance = targetDistanceController.text;
/*
                  if (name.isNotEmpty &&
                      fitnessLevel.isNotEmpty &&
                      targetDistance.isNotEmpty) {
                    // Save the details to Firestore using the DatabaseService
                    DatabaseService(uid: widget.userId)
                        .updateUserData(name, fitnessLevel, targetDistance);

                    // Navigate back to the previous screen
                    Navigator.pop(context);
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Error'),
                        content: const Text('Please enter all fields'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  } */
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
