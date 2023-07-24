import "package:bitfit102/models/myuser.dart";
import "package:bitfit102/screens/authenticate/authenticate.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class Wrapper extends StatelessWidget {
  const Wrapper({super.key, Key? key2});

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser?>(context);
    
    return const Authenticate();
    // return either Home or Authenticate widget
    
    /*
    if (user == null) {
      return const Authenticate();
    } else {
      return CalendarPage(benchPressTarget: user.benchPressTarget, squatTarget: user.squatTarget, deadliftTarget: user.deadliftTarget, targetDistance: user.targetDistance, selectedGoal: user.selectedGoal);
    }
    */
  }

}