import 'package:flutter/material.dart';
import 'package:bitfit102/screens/services/auth.dart';
import 'package:bitfit102/home/home.dart';
import 'package:bitfit102/screens/authenticate/sign_in.dart';
import 'package:table_calendar/table_calendar.dart';
import "package:intl/intl.dart";

class LiftPlanPage extends StatefulWidget {
  final double benchPressTarget;
  final double squatTarget;
  final double deadliftTarget;
  final AuthService _auth = AuthService();

  LiftPlanPage({super.key, 
    required this.benchPressTarget,
    required this.squatTarget,
    required this.deadliftTarget,
  });

  @override
  _LiftPlanPageState createState() => _LiftPlanPageState();
}

class _LiftPlanPageState extends State<LiftPlanPage> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final DateTime _firstDay = DateTime.now().subtract(const Duration(days: 365));
  final DateTime _lastDay = DateTime.now().add(const Duration(days: 365));
  Map<DateTime, String> trainingPlan = {};

@override
void initState() {
  super.initState();
  _selectedDay = DateTime.now(); // Set initial value to DateTime.now()
  trainingPlan = generateTrainingPlan();
}


  Map<DateTime, String> generateTrainingPlan() {
    Map<DateTime, String> trainingPlan = {};

    DateTime currentDate = DateTime.now();
    DateTime startDate =
        currentDate.subtract(Duration(days: currentDate.weekday - DateTime.monday));

    for (int i = 0; i < 7; i++) {
      DateTime workoutDate = startDate.add(Duration(days: i));
      trainingPlan[workoutDate] = getWorkoutForTargetLifts(
        workoutDate.weekday,
        widget.benchPressTarget,
        widget.squatTarget,
        widget.deadliftTarget
      );
    }

    return trainingPlan;
  }

  String getWorkoutForTargetLifts(int day, double benchPressTarget, double squatTarget, double deadliftTarget) {
    switch (day) {
      case DateTime.monday:
        String calculatedSquat = (0.7857 * squatTarget).toString();
        String calculatedBench = (0.7857 * benchPressTarget).toString();
        return '5 sets of 5 $calculatedBench kg Bench Press'"\n" 
        "5 sets of 5 $calculatedSquat kg Squat" ;
      case DateTime.tuesday:
        return 'Rest day';
      case DateTime.wednesday:
        String calculatedSquat = (0.7857 * squatTarget).toString();
        String calculatedBench2 = (0.72222 * benchPressTarget).toString();
        return '4 sets of 8 $calculatedBench2 kg Bench Press'"\n"
        "5 sets of 5 $calculatedSquat kg Squat" ;
      case DateTime.thursday:
        return 'Rest day';
      case DateTime.friday:
        String calculateDeadlift = (0.8 * deadliftTarget).toString();
        String calculatedShoulderPress = (0.5 * benchPressTarget).toString();
        return "5 sets of 5 $calculatedShoulderPress kg Shoulder Press""\n"
        "3 sets of 6 $calculateDeadlift kg Deadlift";
      case DateTime.saturday:
        return 'Rest day';
      case DateTime.sunday:
        return "Rest day";
      default:
        return 'No workout available';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lift Plan'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Home()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await widget._auth.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignIn(toggleView: () {})),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: TableCalendar(
                calendarFormat: _calendarFormat,
                firstDay: _firstDay,
                lastDay: _lastDay,
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                    trainingPlan = generateTrainingPlan();
                    print('Selected Day: $_selectedDay');
                  });
                },
                availableCalendarFormats: const {
                  CalendarFormat.month: 'Month',
                },
                headerStyle: const HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                ),
                calendarStyle: const CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.deepPurple,
                    shape: BoxShape.circle,
                  ),
                  selectedTextStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (_selectedDay != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        DateFormat.yMMMMd().format(_selectedDay!),
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Training Plan: ${getWorkoutForTargetLifts(_selectedDay!.weekday, 
                        widget.benchPressTarget,
                        widget.squatTarget,
                        widget.deadliftTarget)}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
