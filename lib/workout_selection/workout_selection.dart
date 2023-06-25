import 'package:flutter/material.dart';
import 'package:bitfit102/screens/services/auth.dart';
import 'package:bitfit102/selection/running.dart';
import 'package:bitfit102/selection/lifting.dart';

class WorkoutSelection extends StatefulWidget {
  const WorkoutSelection({Key? key}) : super(key: key);

  @override
  _WorkoutSelectionState createState() => _WorkoutSelectionState();
}

class _WorkoutSelectionState extends State<WorkoutSelection> {
  String? selectedGoal;

  // Create an instance of AuthService
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Workout Selection'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'What are your goals?',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ListTile(
              title: const Text('Train for a race'),
              leading: Radio<String>(
                value: 'Train for a race',
                groupValue: selectedGoal,
                onChanged: (value) {
                  setState(() {
                    selectedGoal = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Improve lifting strength'),
              leading: Radio<String>(
                value: 'Improve lifting strength',
                groupValue: selectedGoal,
                onChanged: (value) {
                  setState(() {
                    selectedGoal = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('I want to train both running and lifting'),
              leading: Radio<String>(
                value: 'I want to train both running and lifting',
                groupValue: selectedGoal,
                onChanged: (value) {
                  setState(() {
                    selectedGoal = value;
                  });
                },
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (selectedGoal != null) {
                  final String? userId = await authService.getCurrentUserId();
                  if (userId != null) {
                    print('Selected goal: $selectedGoal');
                    if (selectedGoal == 'Train for a race') {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RunningPage(userId: userId, selectedGoal: selectedGoal),
                        ),
                      );
                    } else if (selectedGoal == 'Improve lifting strength') {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LiftingPage(userId: userId, selectedGoal: selectedGoal),
                        ),
                      );
                    } else if (selectedGoal == 'I want to train both running and lifting') {
                      // Handle both running and lifting case
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RunningPage(userId: userId, selectedGoal: selectedGoal),
                        ),
                      );
                    }
                  }
                } else {
                  print('Please select a goal');
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(
    const MaterialApp(
      home: WorkoutSelection(),
    ),
  );
}
