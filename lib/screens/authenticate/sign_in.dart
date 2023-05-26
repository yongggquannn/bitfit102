import "package:bitfit102/screens/services/auth.dart";
import "package:flutter/material.dart";

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue[200],
          elevation: 0.0,
          title: const Text("Welcome to bitFit102"),
        ),
        body: Column(
          children: [
            Container(
                padding: const EdgeInsets.symmetric(vertical: 150.0, horizontal: 150.0),
                child: ElevatedButton(
                    child: const Text(
                      "Sign in as Guest",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () async {
                      dynamic result = await _auth.signInAnon();
                      if (result == null) {
                        print("error signing in");
                      } else {
                        print("signed in");
                        print(result);
                      }
                    }
                  )
                ),
            const Expanded(
                child: Align(
                alignment: Alignment.center,
                child: Image(
                image: AssetImage(
                  "assets/premium_photo-1669021454207-b4af6335dc90.avif"),
                )
              ),
            ),
          ],
        )
      );
  }
}
