import "package:bitfit102/screens/services/auth.dart";
import "package:flutter/material.dart";

class Home extends StatelessWidget {
  Home({super.key});

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: const Text("bitFit102"),
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
            icon: const Icon(Icons.person),
            label: const Text("Logout"),
            onPressed: () async {
              await _auth.signOut();
            })
        ],
      ),
    );
  }
}