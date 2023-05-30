import 'package:bitfit102/screens/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: const Text('bitFit102'),
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        actions: <Widget>[
          Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
        child: TextButton.icon(
            icon: const Icon(Icons.person, color: Colors.black),
            label: const Text(
              'Logout',
              style: TextStyle(color: Colors.black)
            ),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
        ),
      ],
    ),
      body: const Center(
        child: Text(
          'Under Development',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
