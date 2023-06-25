import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WorkoutData {
  final String workoutType;
  final String workoutName;
  final String repsOrTiming;

  WorkoutData({required this.workoutType, required this.workoutName, required this.repsOrTiming});
}

class WorkoutHistory extends StatefulWidget {
  @override
  _WorkoutHistoryState createState() => _WorkoutHistoryState();
}

class _WorkoutHistoryState extends State<WorkoutHistory> {
  late List<String> runningDistances;
  late List<String> liftTargets;
  String selectedDistance = '';
  String selectedLiftTarget = '';
  TextEditingController repsTimingController = TextEditingController();

  String? defaultDistance;
  String? defaultLiftTarget;

  @override
  void initState() {
    super.initState();
    runningDistances = ["2.4km", '5km', '10km', 'Half Marathon', 'Marathon'];
    liftTargets = ['Bench Press', 'Squat', 'Deadlift'];
    defaultDistance = runningDistances.isNotEmpty ? runningDistances[0] : null;
    defaultLiftTarget = liftTargets.isNotEmpty ? liftTargets[0] : null;
  }

  @override
  void dispose() {
    repsTimingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout History'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Running Distance:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              DropdownButton<String>(
  value: selectedDistance.isNotEmpty ? selectedDistance : defaultDistance,
  items: [
    DropdownMenuItem<String>(
      value: '',
      child: Text('Default'),
    ),
    ...runningDistances.map((String distance) {
      return DropdownMenuItem<String>(
        value: distance,
        child: Text(distance),
      );
    }).toList(),
  ],
  onChanged: (String? value) {
    setState(() {
      if (value == '') {
        selectedDistance = defaultDistance!;
      } else {
        selectedDistance = value!;
      }
    });
  },
)

,

              SizedBox(height: 16.0),
              Text(
                'Lift Target:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              DropdownButton<String>(
  value: selectedLiftTarget.isNotEmpty ? selectedLiftTarget : defaultLiftTarget,
  items: [
    DropdownMenuItem<String>(
      value: '',
      child: Text('Default'),
    ),
    ...liftTargets.map((String target) {
      return DropdownMenuItem<String>(
        value: target,
        child: Text(target),
      );
    }).toList(),
  ],
  onChanged: (String? value) {
    setState(() {
      if (value == '') {
        selectedLiftTarget = defaultLiftTarget!;
      } else {
        selectedLiftTarget = value!;
      }
    });
  },
)

,
              SizedBox(height: 16.0),
              Text(
                'Reps/Timing:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: repsTimingController,
                decoration: InputDecoration(
                  hintText: 'Enter reps or timing',
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  addWorkoutData();
                },
                child: Text('Add Workout'),
              ),
              SizedBox(height: 16.0),
              Text(
                'Workout History:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('workoutData').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<WorkoutData> workoutDataList = [];
                    for (var doc in snapshot.data!.docs) {
                      String workoutType = doc['workoutType'] ?? '';
                      String workoutName = doc['workoutName'] ?? '';
                      String repsOrTiming = doc['repsOrTiming'] ?? '';
                      WorkoutData workoutData = WorkoutData(
                        workoutType: workoutType,
                        workoutName: workoutName,
                        repsOrTiming: repsOrTiming,
                      );
                      workoutDataList.add(workoutData);
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: workoutDataList.length,
                      itemBuilder: (context, index) {
                        WorkoutData workoutData = workoutDataList[index];
                        return ListTile(
                          title: Text('${workoutData.workoutType}: ${workoutData.workoutName} (${workoutData.repsOrTiming})'),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              deleteWorkoutData(workoutData); // Call function to delete workout data
                            },
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addWorkoutData() async {
    String workoutType = '';
    String workoutName = '';
    if (selectedDistance.isNotEmpty) {
      workoutType = 'Running';
      workoutName = selectedDistance;
    } else if (selectedLiftTarget.isNotEmpty) {
      workoutType = 'Lift';
      workoutName = selectedLiftTarget;
    }
    String repsOrTiming = repsTimingController.text.trim();
    if (workoutType.isNotEmpty && workoutName.isNotEmpty && repsOrTiming.isNotEmpty) {
      await FirebaseFirestore.instance.collection('workoutData').add({
        'workoutType': workoutType,
        'workoutName': workoutName,
        'repsOrTiming': repsOrTiming,
      });
      setState(() {
        selectedDistance = '';
        selectedLiftTarget = '';
        repsTimingController.clear();
      });
    }
  }

  Future<void> deleteWorkoutData(WorkoutData workoutData) async {
    await FirebaseFirestore.instance
        .collection('workoutData')
        .where('workoutType', isEqualTo: workoutData.workoutType)
        .where('workoutName', isEqualTo: workoutData.workoutName)
        .where('repsOrTiming', isEqualTo: workoutData.repsOrTiming)
        .get()
        .then((snapshot) {
      for (DocumentSnapshot doc in snapshot.docs) {
        doc.reference.delete();
      }
    });
  }
}
