import "package:bitfit102/home/home.dart";
import "package:bitfit102/models/myuser.dart";
import "package:bitfit102/screens/authenticate/authenticate.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key});

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser?>(context);
    
    // return either Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}