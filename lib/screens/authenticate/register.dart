import "package:bitfit102/screens/services/auth.dart";
import "package:flutter/material.dart";
import "package:bitfit102/shared/constants.dart";

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
            Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
        child: TextButton.icon(
              icon: Icon(Icons.person, color: Colors.black),
              label: Text("Sign In", style: TextStyle(color: Colors.black)),
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
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: "Email"),
                        validator: (val) => val!.isEmpty ? "Enter an email" : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        }
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: "Password"),
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
                            if( result == null) {
                              setState(() => error = 'Please enter a valid email');
                            }
                          }
                          
                        }
                      ),
                      SizedBox(height: 12.0), 
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 20.0), // Add some spacing
          Image.asset(
            'assets/photo-1517963879433-6ad2b056d712.avif',
            fit: BoxFit.contain,
            width: 400,
            height: 400,
          ), 
        ],
       )
    );
  }
}
