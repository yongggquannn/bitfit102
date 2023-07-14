import 'package:flutter/material.dart';
import 'package:bitfit102/screens/services/auth.dart';
import 'package:bitfit102/home/home.dart';
import 'package:bitfit102/screens/authenticate/sign_in.dart';
import 'package:table_calendar/table_calendar.dart';
import "package:intl/intl.dart";

class CalendarPage extends StatefulWidget {
  final double benchPressTarget;
  final double squatTarget;
  final double deadliftTarget;
  final String targetDistance;
  final String? selectedGoal;
  final String? fitnessLevel;
  final AuthService _auth = AuthService();

  CalendarPage({
    Key? key,
    required this.benchPressTarget,
    required this.squatTarget,
    required this.deadliftTarget,
    required this.targetDistance,
    required this.selectedGoal,
    this.fitnessLevel,
  }) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
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
    DateTime startDate = currentDate.subtract(Duration(days: currentDate.weekday - DateTime.monday));

    if (widget.selectedGoal == "Train for a race") {
      for (int i = 0; i < 7; i++) {
        DateTime workoutDate = startDate.add(Duration(days: i));
        trainingPlan[workoutDate] = getWorkoutForTargetDistance(workoutDate.weekday, widget.targetDistance, widget.fitnessLevel);
      }
    }

    if (widget.selectedGoal == "Improve lifting strength") {
      for (int i = 0; i < 7; i++) {
        DateTime workoutDate = startDate.add(Duration(days: i));
        trainingPlan[workoutDate] = getWorkoutForTargetLifts(workoutDate.weekday, widget.benchPressTarget, widget.squatTarget, widget.deadliftTarget);
      }
    }

    if (widget.selectedGoal == 'I want to train both running and lifting') {
      for (int i = 0; i < 7; i++) {
        DateTime workoutDate = startDate.add(Duration(days: i));
        trainingPlan[workoutDate] = getWorkoutforHyrbrid(workoutDate.weekday, widget.targetDistance, widget.benchPressTarget, widget.squatTarget, widget.deadliftTarget, widget.fitnessLevel);
      }
    }
    return trainingPlan;
  }

  String getWorkoutforHyrbrid(int day, String targetDistance, double benchPressTarget, double squatTarget, double deadliftTarget, String? fitnessLevel) {
    switch (day) {
      case DateTime.monday:
        return getWorkoutForTargetLifts(day, benchPressTarget, squatTarget, deadliftTarget);
      case DateTime.tuesday:
        return getWorkoutForTargetDistance(day, targetDistance, fitnessLevel);
      case DateTime.wednesday:
        return getWorkoutForTargetLifts(day, benchPressTarget, squatTarget, deadliftTarget);
      case DateTime.thursday:
        return getWorkoutForTargetDistance(day, targetDistance, fitnessLevel);
      case DateTime.friday:
        return getWorkoutForTargetLifts(day, benchPressTarget, squatTarget, deadliftTarget);
      case DateTime.saturday:
        return getWorkoutForTargetDistance(day, targetDistance, fitnessLevel);
      case DateTime.sunday:
        return "Rest Day";
      default:
        return 'No workout available';
    }
  }

  String getWorkoutForTargetLifts(int day, double benchPressTarget, double squatTarget, double deadliftTarget) {
    switch (day) {
      case DateTime.monday:
        String calculatedSquat = (0.7857 * squatTarget).ceil().toString();
        String calculatedBench = (0.7857 * benchPressTarget).ceil().toString();
        return '5 sets of 5 $calculatedBench kg Bench Press' "\n" '5 sets of 5 $calculatedSquat kg Squat';
      case DateTime.tuesday:
        return 'Rest day';
      case DateTime.wednesday:
        String calculatedSquat = (0.7857 * squatTarget).ceil().toString();
        String calculatedBench2 = (0.72222 * benchPressTarget).ceil().toString();
        return '4 sets of 8 $calculatedBench2 kg Bench Press' "\n" '5 sets of 5 $calculatedSquat kg Squat';
      case DateTime.thursday:
        return 'Rest day';
      case DateTime.friday:
        String calculateDeadlift = (0.8 * deadliftTarget).ceil().toString();
        String calculatedShoulderPress = (0.5 * benchPressTarget).ceil().toString();
        return "5 sets of 5 $calculatedShoulderPress kg Shoulder Press" "\n" "3 sets of 6 $calculateDeadlift kg Deadlift";
      case DateTime.saturday:
        return 'Rest day';
      case DateTime.sunday:
        return "Rest day";
      default:
        return 'No workout available';
    }
  }

  String getWorkoutForTargetDistance(int day, String targetDistance, String? fitnessLevel) {
    switch (targetDistance) {
      case '2.4km':
        return getWorkoutFor2_4K(day, fitnessLevel);
      case '5km':
        return getWorkoutFor5K(day, fitnessLevel);
      case '10km':
        return getWorkoutFor10K(day, fitnessLevel);
      case '21km':
        return getWorkoutFor21K(day, fitnessLevel);
      case '42km':
        return getWorkoutFor42K(day, fitnessLevel);
      default:
        return 'No workout available';
    }
  }

  String getWorkoutFor2_4K(int day, String? fitnessLevel) {
    print('Fitness Level: $fitnessLevel');
    switch (fitnessLevel) {
      case 'Beginner':
        return getBeginnerWorkoutFor2_4K(day);
      case 'Intermediate':
        return getIntermediateWorkoutFor2_4K(day);
      case 'Advanced':
        return getAdvancedWorkoutFor2_4K(day);
      default:
        return '';
    }
  }

  String getBeginnerWorkoutFor2_4K(int day) {
    switch (day) {
      case DateTime.monday:
        return 'Beginner 2.4K Workout: 1km warm-up, 3km at an easy pace, 1km cool-down';
      case DateTime.tuesday:
        return 'Rest day';
      case DateTime.wednesday:
        return 'Beginner 2.4K Workout: 800m intervals x (4-6), with 400m recovery jog';
      case DateTime.thursday:
        return 'Beginner 2.4K Workout: 5km long run at an easy pace';
      case DateTime.friday:
        return 'Beginner 2.4K Workout: 400m intervals x 6 at race pace';
      case DateTime.saturday:
        return 'Rest day';
      case DateTime.sunday:
        return '60 min easy run';
      default:
        return 'No workout available';
    }
  }

  String getIntermediateWorkoutFor2_4K(int day) {
    switch (day) {
      case DateTime.monday:
        return 'Intermediate 2.4K Workout: 2km warm-up, 4km at a steady pace, 2km cool-down';
      case DateTime.tuesday:
        return 'Rest day';
      case DateTime.wednesday:
        return 'Intermediate 2.4K Workout: 1km intervals x (4-6), with 400m recovery jog';
      case DateTime.thursday:
        return 'Intermediate 2.4K Workout: 6km long run at an easy pace';
      case DateTime.friday:
        return 'Intermediate 2.4K Workout: 400m intervals x 8 at race pace';
      case DateTime.saturday:
        return 'Rest day';
      case DateTime.sunday:
        return '60 min easy run';
      default:
        return 'No workout available';
    }
  }

  String getAdvancedWorkoutFor2_4K(int day) {
    switch (day) {
      case DateTime.monday:
        return 'Advanced 2.4K Workout: 2km warm-up, 6km at a steady pace, 2km cool-down';
      case DateTime.tuesday:
        return 'Rest day';
      case DateTime.wednesday:
        return 'Advanced 2.4K Workout: 1km intervals x 10, with 400m recovery jog';
      case DateTime.thursday:
        return 'Advanced 2.4K Workout: 7km long run at an easy pace';
      case DateTime.friday:
        return 'Advanced 2.4K Workout: 800m intervals x 8 at race pace';
      case DateTime.saturday:
        return 'Rest day';
      case DateTime.sunday:
        return '60 min easy run';
      default:
        return 'No workout available';
    }
  }

  String getWorkoutFor5K(int day, String? fitnessLevel) {
    switch (fitnessLevel) {
      case 'Beginner':
        return getBeginnerWorkoutFor5K(day);
      case 'Intermediate':
        return getIntermediateWorkoutFor5K(day);
      case 'Advanced':
        return getAdvancedWorkoutFor5K(day);
      default:
        return 'No workout available';
    }
  }

  String getBeginnerWorkoutFor5K(int day) {
    switch (day) {
      case DateTime.monday:
        return 'Beginner 5K Workout: 1km warm-up, 4km at a moderate pace, 1km cool-down';
      case DateTime.tuesday:
        return 'Rest day';
      case DateTime.wednesday:
        return 'Beginner 5K Workout: 800m intervals x 6, with 400m recovery jog';
      case DateTime.thursday:
        return 'Rest day';
      case DateTime.friday:
        return 'Beginner 5K Workout: 4km easy run';
      case DateTime.saturday:
        return 'Beginner 5K Workout: 3km tempo';
      case DateTime.sunday:
        return 'Rest day';
      default:
        return 'No workout available';
    }
  }

  String getIntermediateWorkoutFor5K(int day) {
    switch (day) {
      case DateTime.monday:
        return 'Intermediate 5K Workout: 2km warm-up, 6km at a steady pace, 2km cool-down';
      case DateTime.tuesday:
        return 'Rest day';
      case DateTime.wednesday:
        return 'Intermediate 5K Workout: 1km intervals x 7, with 400m recovery jog';
      case DateTime.thursday:
        return 'Rest day';
      case DateTime.friday:
        return 'Intermediate 5K Workout: 6km easy run';
      case DateTime.saturday:
        return 'Intermediate 5K Workout: 4km tempo';
      case DateTime.sunday:
        return 'Rest day';
      default:
        return 'No workout available';
    }
  }

  String getAdvancedWorkoutFor5K(int day) {
    switch (day) {
      case DateTime.monday:
        return 'Advanced 5K Workout: 2km warm-up, 6km at a steady pace, 2km cool-down';
      case DateTime.tuesday:
        return 'Rest day';
      case DateTime.wednesday:
        return 'Advanced 5K Workout: 1km intervals x 10, with 400m recovery jog';
      case DateTime.thursday:
        return 'Rest day';
      case DateTime.friday:
        return 'Advanced 5K Workout: 8km easy run';
      case DateTime.saturday:
        return 'Advanced 5K Workout: 5km tempo';
      case DateTime.sunday:
        return 'Rest day';
      default:
        return 'No workout available';
    }
  }

  String getWorkoutFor10K(int day, String? fitnessLevel) {
  switch (fitnessLevel) {
    case 'Beginner':
      return getBeginnerWorkoutFor10K(day);
    case 'Intermediate':
      return getIntermediateWorkoutFor10K(day);
    case 'Advanced':
      return getAdvancedWorkoutFor10K(day);
    default:
      return 'No workout available';
  }
}

String getBeginnerWorkoutFor10K(int day) {
  switch (day) {
    case DateTime.monday:
      return 'Beginner 10K Workout: 1km warm-up, 6km at a steady pace, 1km cool-down';
    case DateTime.tuesday:
      return 'Rest day';
    case DateTime.wednesday:
      return 'Beginner 10K Workout: 1km intervals x 5, with 400m recovery jog';
    case DateTime.thursday:
      return 'Rest day';
    case DateTime.friday:
      return 'Beginner 10K Workout: 7km easy run';
    case DateTime.saturday:
      return 'Beginner 10K Workout: 6km tempo';
    case DateTime.sunday:
      return 'Rest day';
    default:
      return 'No workout available';
  }
}

String getIntermediateWorkoutFor10K(int day) {
  switch (day) {
    case DateTime.monday:
      return 'Intermediate 10K Workout: 2km warm-up, 8km at a steady pace, 2km cool-down';
    case DateTime.tuesday:
      return 'Rest day';
    case DateTime.wednesday:
      return 'Intermediate 10K Workout: 1km intervals x 6, with 400m recovery jog';
    case DateTime.thursday:
      return 'Rest day';
    case DateTime.friday:
      return 'Intermediate 10K Workout: 8km easy run';
    case DateTime.saturday:
      return 'Intermediate 10K Workout: 7km tempo';
    case DateTime.sunday:
      return 'Rest day';
    default:
      return 'No workout available';
  }
}

String getAdvancedWorkoutFor10K(int day) {
  switch (day) {
    case DateTime.monday:
      return 'Advanced 10K Workout: 2km warm-up, 8km at a steady pace, 2km cool-down';
    case DateTime.tuesday:
      return 'Rest day';
    case DateTime.wednesday:
      return 'Advanced 10K Workout: 1km intervals x 10, with 400m recovery jog';
    case DateTime.thursday:
      return 'Rest day';
    case DateTime.friday:
      return 'Advanced 10K Workout: 10km easy run';
    case DateTime.saturday:
      return 'Advanced 10K Workout: 8km tempo';
    case DateTime.sunday:
      return 'Rest day';
    default:
      return 'No workout available';
  }
}

String getWorkoutFor21K(int day, String? fitnessLevel) {
  switch (fitnessLevel) {
    case 'Beginner':
      return getBeginnerWorkoutFor21K(day);
    case 'Intermediate':
      return getIntermediateWorkoutFor21K(day);
    case 'Advanced':
      return getAdvancedWorkoutFor21K(day);
    default:
      return 'No workout available';
  }
}

String getBeginnerWorkoutFor21K(int day) {
  switch (day) {
    case DateTime.monday:
      return 'Beginner 21K Workout: 2km warm-up, 10km at a steady pace, 2km cool-down';
    case DateTime.tuesday:
      return 'Rest day';
    case DateTime.wednesday:
      return 'Beginner 21K Workout: 1km intervals x 8, with 400m recovery jog';
    case DateTime.thursday:
      return 'Rest day';
    case DateTime.friday:
      return 'Beginner 21K Workout: 60 min easy run';
    case DateTime.saturday:
      return 'Beginner 21K Workout: 7km tempo';
    case DateTime.sunday:
      return 'Rest day';
    default:
      return 'No workout available';
  }
}

String getIntermediateWorkoutFor21K(int day) {
  switch (day) {
    case DateTime.monday:
      return 'Intermediate 21K Workout: 2km warm-up, 12km at a steady pace, 2km cool-down';
    case DateTime.tuesday:
      return 'Rest day';
    case DateTime.wednesday:
      return 'Intermediate 21K Workout: 1km intervals x 10(tempo pace), with 400m recovery jog';
    case DateTime.thursday:
      return 'Rest day';
    case DateTime.friday:
      return 'Intermediate 21K Workout: 70 min easy run';
    case DateTime.saturday:
      return 'Intermediate 21K Workout: 8km tempo';
    case DateTime.sunday:
      return 'Rest day';
    default:
      return 'No workout available';
  }
}

String getAdvancedWorkoutFor21K(int day) {
  switch (day) {
    case DateTime.monday:
      return 'Advanced 21K Workout: 2km warm-up, 14km at a steady pace, 2km cool-down';
    case DateTime.tuesday:
      return 'Rest day';
    case DateTime.wednesday:
      return 'Advanced 21K Workout: 1km intervals x 10(close to race pace), with 400m recovery jog';
    case DateTime.thursday:
      return 'Rest day';
    case DateTime.friday:
      return 'Advanced 21K Workout: 90 min easy run';
    case DateTime.saturday:
      return 'Advanced 21K Workout: 8km tempo, followed by 200m x4 fast reps';
    case DateTime.sunday:
      return 'Rest day';
    default:
      return 'No workout available';
  }
}

String getWorkoutFor42K(int day, String? fitnessLevel) {
  switch (fitnessLevel) {
    case 'Beginner':
      return getBeginnerWorkoutFor42K(day);
    case 'Intermediate':
      return getIntermediateWorkoutFor42K(day);
    case 'Advanced':
      return getAdvancedWorkoutFor42K(day);
    default:
      return 'No workout available';
  }
}

String getBeginnerWorkoutFor42K(int day) {
  switch (day) {
    case DateTime.monday:
      return 'Beginner 42K Workout: 2km warm-up, 12km at a steady-moderate pace, 2km cool-down';
    case DateTime.tuesday:
      return 'Beginner 42K Workout: 10km easy run';
    case DateTime.wednesday:
      return 'Beginner 42K Workout: 1.2km intervals x 6, with 400m recovery jog';
    case DateTime.thursday:
      return 'Rest day';
    case DateTime.friday:
      return 'Beginner 42K Workout: 70 mins easy run';
    case DateTime.saturday:
      return 'Beginner 42K Workout: 7km tempo';
    case DateTime.sunday:
      return 'Rest day';
    default:
      return 'No workout available';
  }
}

String getIntermediateWorkoutFor42K(int day) {
  switch (day) {
    case DateTime.monday:
      return 'Intermediate 42K Workout: 2km warm-up, 15km at a steady-moderate pace, 2km cool-down';
    case DateTime.tuesday:
      return 'Intermediate 42K Workout: 12km easy run';
    case DateTime.wednesday:
      return 'Intermediate 42K Workout: 1.5km intervals x 8, with 400m recovery jog';
    case DateTime.thursday:
      return 'Rest day';
    case DateTime.friday:
      return 'Intermediate 42K Workout: 90 mins easy run';
    case DateTime.saturday:
      return 'Intermediate 42K Workout: 8km tempo';
    case DateTime.sunday:
      return 'Rest day';
    default:
      return 'No workout available';
  }
}

String getAdvancedWorkoutFor42K(int day) {
  switch (day) {
    case DateTime.monday:
      return 'Advanced 42K Workout: 2km warm-up, 18km at a steady-moderate pace, 2km cool-down';
    case DateTime.tuesday:
      return 'Advanced 42K Workout: 15km easy run';
    case DateTime.wednesday:
      return 'Advanced 42K Workout: 2km intervals x 10, with 400m recovery jog';
    case DateTime.thursday:
      return 'Rest day';
    case DateTime.friday:
      return 'Advanced 42K Workout: 90 mins easy run';
    case DateTime.saturday:
      return 'Advanced 42K Workout: 8km tempo, followed by 200m x 4 fast reps ';
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
        title: const Text('Training Plan'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home(calendarPage: widget)),
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
                      if (widget.selectedGoal == "Improve lifting strength")
                        Column(
                          children: [
                            Text(
                              DateFormat.yMMMMd().format(_selectedDay!),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Training Plan -> ${getWorkoutForTargetLifts(_selectedDay!.weekday, widget.benchPressTarget, widget.squatTarget, widget.deadliftTarget)}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      if (widget.selectedGoal == "Train for a race")
                        Column(
                          children: [
                            Text(
                              DateFormat.yMMMMd().format(_selectedDay!),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Training Plan -> ${getWorkoutForTargetDistance(_selectedDay!.weekday, widget.targetDistance, widget.fitnessLevel)}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      if (widget.selectedGoal == 'I want to train both running and lifting')
                        Column(
                          children: [
                            Text(
                              DateFormat.yMMMMd().format(_selectedDay!),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Training Plan -> ${getWorkoutforHyrbrid(_selectedDay!.weekday, widget.targetDistance, widget.benchPressTarget, widget.squatTarget, widget.deadliftTarget, widget.fitnessLevel)}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
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
