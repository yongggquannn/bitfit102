import "package:flutter/material.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:provider/provider.dart";

class ProfileList extends StatefulWidget {
  const ProfileList({super.key});

  @override
  State<ProfileList> createState() => _ProfileListState();
}

class _ProfileListState extends State<ProfileList> {
  @override
  Widget build(BuildContext context) {

    final profiles = Provider.of<QuerySnapshot?>(context);
    if (profiles != null) {
      for (var doc in profiles.docs) {
        print(doc.data());
      }
    }
    return Container(

    );
  }
}