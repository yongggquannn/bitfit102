
import "package:cloud_firestore/cloud_firestore.dart";

class DatabaseService {
  
  final String uid;
  DatabaseService({required this.uid });
  // collection reference
  final CollectionReference profileCollection = FirebaseFirestore.instance.collection("profiles");

  Future updateUserData(String name, String fitnessLevel, String? targetDistance, double? benchPressTarget,
    double? squatTarget, double? deadliftTarget) async {
    return await profileCollection.doc(uid).set({
      "name" : name,
      "fitnessLevel" : fitnessLevel,
      "targetDistance" : targetDistance,
      "benchPressTarget" : benchPressTarget,
      "squatTarget" : squatTarget,
      "deadliftTarget" : deadliftTarget
    });
  }

  // get users stream
  Stream<QuerySnapshot> get profiles {
    return profileCollection.snapshots();   
  }

  

}