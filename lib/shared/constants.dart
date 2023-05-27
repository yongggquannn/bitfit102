import "package:flutter/material.dart";

const textInputDecoration = InputDecoration(
  hintText: "Email",
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(width: 2.0)
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 2.0)
  ),
);

const passwordInputDecoration = InputDecoration(
  hintText: "Password",
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(width: 2.0)
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 2.0)
  ),
);
