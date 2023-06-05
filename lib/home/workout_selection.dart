import 'package:flutter/material.dart';
import "package:bitfit102/home/home.dart";

class WorkoutSelection extends StatefulWidget {
  const WorkoutSelection({super.key, Key? keyworkoutSelection});

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
              'What is your goal?',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            RadioListTile(
              title: const Text('Train for a race'),
              value: 'Train for a race',
              groupValue: selectedGoal,
              onChanged: (value) {
                setState(() {
                  selectedGoal = value;
                });
              },
            ),
            RadioListTile(
              title: const Text('Improve lifting strength'),
              value: 'Improve lifting strength',
              groupValue: selectedGoal,
              onChanged: (value) {
                setState(() {
                  selectedGoal = value;
                });
              },
            ),
            RadioListTile(
              title: const Text('I want to train both running and lifting'),
              value: 'I want to train both running and lifting',
              groupValue: selectedGoal,
              onChanged: (value) {
                setState(() {
                  selectedGoal = value;
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (selectedGoal != null) {
                  print('Selected goal: $selectedGoal');
                  // Add your logic here based on the selected goal
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Home()),
                  );
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
