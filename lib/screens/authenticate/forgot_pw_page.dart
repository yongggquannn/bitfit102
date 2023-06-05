import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:bitfit102/shared/constants.dart";

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text('Please enter a valid email'),
          );
        },
      );
      return;
    }
    try {
      await FirebaseAuth.instance
        .sendPasswordResetEmail(email: email);
      showDialog(
        context: context, 
        builder: (context) {
          return const AlertDialog(
            content: Text("Password reset link sent!"),
          );
        });
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
        context: context, 
        builder: (context) {
          return AlertDialog(
            content: Text(e.message.toString()),
          );
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              "Enter your email for a password-reset link",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
              ),
          ),
          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child:  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: "Email"),
                    controller: _emailController,
                  ),
          ),
          const SizedBox(height: 10),

          MaterialButton(
            onPressed: () => passwordReset(),
            color: Colors.blue,
            child: const Text("Reset password"),
          )
        ],
      ),
    );
  }
}