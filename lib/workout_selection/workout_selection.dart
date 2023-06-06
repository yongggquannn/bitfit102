import 'package:flutter/material.dart';
import "package:bitfit102/selection/running.dart";
import 'package:provider/provider.dart';
import 'package:bitfit102/screens/services/auth.dart';

class WorkoutSelection extends StatefulWidget {
  const WorkoutSelection({super.key});

  @override
  _WorkoutSelectionState createState() => _WorkoutSelectionState();
}

class _WorkoutSelectionState extends State<WorkoutSelection> {
  String? selectedGoal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              leading: Radio(
                value: 'Train for a race',
                groupValue: selectedGoal,
                onChanged: (value) {
                  setState(() {
                    selectedGoal = "";
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Improve lifting strength'),
              leading: Radio(
                value: 'Improve lifting strength',
                groupValue: selectedGoal,
                onChanged: (value) {
                  setState(() {
                    selectedGoal = "";
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('I want to train both running and lifting'),
              leading: Radio(
                value: 'I want to train both running and lifting',
                groupValue: selectedGoal,
                onChanged: (value) {
                  setState(() {
                    selectedGoal = "";
                  });
                },
              ),
            ),
            ElevatedButton(
  onPressed: () async {
    if (selectedGoal != null) {
      print('Selected goal: $selectedGoal');
      // Retrieve the AuthService using Provider
      final authService = Provider.of<AuthService>(context, listen: false);

      // Retrieve the current user
      final user = await authService.getCurrentUser();

      if (user != null) {
        final uid = user.uid;
        // Add your logic here based on the selected goal
        if (selectedGoal == 'Train for a race') {
          Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RunningPage(),
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
  runApp(const MaterialApp(
    home: WorkoutSelection(),
  ));
}
