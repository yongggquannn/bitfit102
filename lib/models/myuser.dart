import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  
  final String? uid;

  MyUser({ this.uid });
}

class MyUserModel {

  final String? uid;
  final String name;
  final String selectedGoal;
  final String? targetDistance;
  final double? benchPressTarget;
  final double? squatTarget;
  final double? deadliftTarget;

  const MyUserModel({
    this.uid,
    required this.name,
    required this.selectedGoal,
    required this.targetDistance,
    required this.benchPressTarget,
    required this.squatTarget,
    required this.deadliftTarget
  });

  toJson() {
    return {"Name:": name, "Selected Goal": selectedGoal, "Target Distance": targetDistance, 
    "Bench Press Target": benchPressTarget, "Squat Target" : squatTarget, "Deadlift Target": deadliftTarget
    };
  }

  /// Map user fetched from Firebase to UserModel
  factory MyUserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return MyUserModel(
      uid: document.id,
      name: data["Name"], selectedGoal: data["Selected Goal"], targetDistance: data["Target Distance"], benchPressTarget: data["Bench Press Target"], squatTarget: data["Squat Target"], deadliftTarget: data["Deadlift Target"]);
  }

}