import 'package:flutter/material.dart';
import 'package:bitfit102/screens/services/auth.dart';
import 'package:bitfit102/home/home.dart';
import 'package:bitfit102/screens/authenticate/sign_in.dart';
import 'package:table_calendar/table_calendar.dart';
import "package:intl/intl.dart";

class RunPlanPage extends StatefulWidget {
  final String targetDistance;
  final AuthService _auth = AuthService();

  RunPlanPage({required this.targetDistance});

  @override
  _RunPlanPageState createState() => _RunPlanPageState();
}

class _RunPlanPageState extends State<RunPlanPage> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final DateTime _firstDay = DateTime.now().subtract(const Duration(days: 365));
  final DateTime _lastDay = DateTime.now().add(const Duration(days: 365));
  Map<DateTime, String> trainingPlan = {};
  final int _selectedMonth = DateTime.now().month;
  final int _selectedYear = DateTime.now().year;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    trainingPlan = generateTrainingPlan();
  }

Map<DateTime, String> generateTrainingPlan() {
    Map<DateTime, String> trainingPlan = {};

    DateTime currentDate = DateTime.now();
    DateTime startDate = currentDate.subtract(Duration(days: currentDate.weekday - DateTime.monday));

    for (int i = 0; i < 7; i++) {
      DateTime workoutDate = startDate.add(Duration(days: i));
      trainingPlan[workoutDate] = getWorkoutForTargetDistance(workoutDate.weekday, widget.targetDistance);
    }

    return trainingPlan;
  }

String getWorkoutForTargetDistance(int day, String targetDistance) {
    switch (targetDistance) {
      case '2.4km':
        return getWorkoutFor2_4K(day);
      case '5km':
        return getWorkoutFor5K(day);
      case '10km':
        return getWorkoutFor10K(day);
      case '21km':
        return getWorkoutFor21K(day);
      case '42km':
        return getWorkoutFor42K(day);
      default:
        return 'No workout available';
    }
  } 
  

String getWorkoutFor2_4K(int day) {
  switch (day) {
    case DateTime.monday:
      return '1km warm-up, 3km at a steady pace, 1km cool-down';
    case DateTime.tuesday:
      return 'Rest day';
    case DateTime.wednesday:
      return '800m intervals x 6, with 400m recovery jog';
    case DateTime.thursday:
      return '5km long run at easy pace';
    case DateTime.friday:
      return '400m intervals x 10 at race pace';
    case DateTime.saturday:
      return 'Rest day';
    case DateTime.sunday:
      return '60mins easy run';
    default:
      return 'No workout available';
  }
}


String getWorkoutFor5K(int day) {
  switch (day) {
    case DateTime.monday:
      return '1km warm-up, 3km at a steady pace, 1km cool-down';
    case DateTime.tuesday:
      return 'Rest day';
    case DateTime.wednesday:
      return '800m intervals x 6, with 400m recovery jog';
    case DateTime.thursday:
      return 'Rest day';
    case DateTime.friday:
      return '1.5km easy run';
    case DateTime.saturday:
      return '3km tempo';
    case DateTime.sunday:
      return 'Rest day';
    default:
      return 'No workout available';
  }
}

String getWorkoutFor10K(int day) {
  switch (day) {
    case DateTime.monday:
      return '2km warm-up, 6km at a steady pace, 2km cool-down';
    case DateTime.tuesday:
      return 'Rest day';
    case DateTime.wednesday:
      return '1km intervals x 6, with 400m recovery jog';
    case DateTime.thursday:
      return 'Rest day';
    case DateTime.friday:
      return '2km easy run';
    case DateTime.saturday:
      return '4km tempo run';
    case DateTime.sunday:
      return 'Rest day';
    default:
      return 'No workout available';
  }
}

String getWorkoutFor21K(int day) {
  switch (day) {
    case DateTime.monday:
      return '3km warm-up, 15km at a steady pace, 3km cool-down';
    case DateTime.tuesday:
      return 'Rest day';
    case DateTime.wednesday:
      return '1km intervals x 10, with 400m recovery jog';
    case DateTime.thursday:
      return 'Rest day';
    case DateTime.friday:
      return '3km easy run';
    case DateTime.saturday:
      return '7km tempo run';
    case DateTime.sunday:
      return 'Rest day';
    default:
      return 'No workout available';
  }
}

String getWorkoutFor42K(int day) {
  switch (day) {
    case DateTime.monday:
      return '2km warm-up, 12km at a steady-moderate pace, 2km cool-down';
    case DateTime.tuesday:
      return '10km easy run';
    case DateTime.wednesday:
      return '1.2km intervals x 6, with 400m recovery jog';
    case DateTime.thursday:
      return 'Rest day';
    case DateTime.friday:
      return '70 mins easy run';
    case DateTime.saturday:
      return '7km tempo run';
    case DateTime.sunday:
      return 'Rest day';
    default:
      return 'No workout available';
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Run Plan'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
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
                  }
                  );
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
      'Training Plan: ${getWorkoutForTargetDistance(_selectedDay!.weekday, widget.targetDistance)}', // Print training plan
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
