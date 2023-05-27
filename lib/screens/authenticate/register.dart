import "package:bitfit102/screens/services/auth.dart";
import "package:flutter/material.dart";

class Register extends StatefulWidget {

  final Function toggleView;
  const Register({ required this.toggleView });

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // text field state
  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue[400],
          elevation: 0.0,
          title: const Text("Sign up to bitFit102"),
          actions: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.person, color: Colors.black),
              label: Text("Sign In", style: TextStyle(color: Colors.black)),
              onPressed: () {
                widget.toggleView();
              }
            )
          ],
        ),
        body: ListView(
          children: [
            Container(
                padding: const EdgeInsets.symmetric(vertical: 150.0, horizontal: 150.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      TextFormField(
                        validator: (val) => val!.isEmpty ? "Enter an email" : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        }
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        obscureText: true,
                        validator: (val) => val!.length < 6 ? "Enter a password 6+ chars long" : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        }
                      ),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.pink[400],
                        ),
                        child: Text(
                          "Register",
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() => error = "Please enter a valid email");
                            }
                          }
                        }
                      ),
                      SizedBox(height: 12.0), 
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      )
                    ],
                  ),
                ),
              ),
            const Expanded(
                child: Align(
                alignment: Alignment.topCenter,
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
