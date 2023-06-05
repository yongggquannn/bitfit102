import 'package:bitfit102/screens/services/auth.dart';
import 'package:bitfit102/shared/constants.dart';
import 'package:flutter/material.dart';
import "package:bitfit102/shared/loading.dart";
import "package:bitfit102/screens/authenticate/forgot_pw_page.dart";
import "package:bitfit102/home/workout_selection.dart";

class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn({super.key, required this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
Widget build(BuildContext context) {
  return loading ? const Loading() : Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      backgroundColor: Colors.blue[400],
      elevation: 0.0,
      title: const Text('Welcome to bitFit102'),
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
              'Register',
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              widget.toggleView();
            },
          ),
        ),
      ],
    ),
    body: ListView(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20.0, width: 400),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: "Email"),
                  validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: "Password"),
                  validator: (val) => val!.length < 6 ? 'Enter a password 6+ chars long' : null,
                  obscureText: true,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
                const SizedBox(height: 10.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[400],
                  ),
                  child: const Text(
                    'Sign in',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() => loading = true);
                      dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                      if (result == null) {
                        setState(() {
                          error = 'Invalid credentials, please try again';
                          loading = false;
                        });
                      } else {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => const WorkoutSelection(),
                          )
                        );
                      }
                    }
                  },
                ),
                const SizedBox(height: 12.0),
                Text(
                  error,
                  style: const TextStyle(color: Colors.red, fontSize: 14.0),
                ),
                const SizedBox(),
                Column(
                  children: [
                    TextButton(
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold, fontSize: 15.0),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const ForgotPasswordPage();
                            },
                          ),
                        );
                      },
                    ),
                    const SizedBox(),
                    TextButton(
                      child: const Text(
                        'Sign in as guest',
                        style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold, fontSize: 15.0),
                      ),
                      onPressed: () async {
                        dynamic result = await _auth.signInAnon();
                        if (result == null) {
                          setState(() => error = 'Error signing in anonymously');
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
          const SizedBox(height: 20.0), // Add some spacing
          Image.asset(
            'assets/premium_photo-1669021454207-b4af6335dc90.avif',
            fit: BoxFit.contain,
            width: 300,
            height: 300,
          ),
        ],
      ),
    );
  }
}