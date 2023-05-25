import "package:bitfit102/screens/services/auth.dart";
import "package:flutter/material.dart";

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.blue[400],
    appBar: AppBar(
      backgroundColor: Colors.blue[200],
      elevation: 0.0,
      title: const Text("Sign in to bitFit102"),
    ),
    body: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("src/images/Running.png"),
          fit: BoxFit.fill,
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
      child: TextButton(
        child: const Text("Sign in as guest"),
        onPressed: () async {
          dynamic result = await _auth.signInAnon();
          if (result == null) {
            print("Error signing in");
          } else {
            print("Signed in");
            print(result);
          }
        },
      ),
    ),
  );
}
}