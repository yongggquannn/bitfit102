import "package:bitfit102/home/workout_history.dart";
import "package:bitfit102/screens/authenticate/sign_in.dart";
import 'package:bitfit102/screens/services/auth.dart';
import "package:bitfit102/workout_selection/workout_selection.dart";
import 'package:flutter/material.dart';
import "package:bitfit102/screens/services/database.dart";
import "package:provider/provider.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:bitfit102/home/profile_list.dart";
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import "package:bitfit102/home/videos_page.dart";

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  List<ExpansionPanelItem> panelItems = []; // Updated: Use a list to store expansion panel items

  @override
  void initState() {
    super.initState();
    // Initialize the expansion panel items
    panelItems = [
      ExpansionPanelItem(
        headerText: 'Homepage',
        children: [
          'Explore Workout Plans',
          'Workout History',
          "Change Workout Selection"
        ],
        isExpanded: false, // Updated: Set the initial expansion state for each item
      ),
    ];

    
  }

  void _expandCallback(int index) {
    setState(() {
      // Toggle the expansion state for the selected item
      panelItems[index].isExpanded = !panelItems[index].isExpanded;
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot?>.value(
      initialData: null,
      value: DatabaseService(uid: "").profiles,
      child: Scaffold(
        backgroundColor: Colors.blue[50],
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Welcome, User'), 
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
                Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignIn(toggleView: () {})),
              );
              },
            ),
          ),
        ],
      ),
      body: Column(
  children: <Widget>[
    Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ExpansionPanelList(
              elevation: 1,
              expandedHeaderPadding: const EdgeInsets.all(0),
              expansionCallback: (int index, bool isExpanded) {
                _expandCallback(index); // Updated: Pass the index to the expansion callback
              },
              children: panelItems.map<ExpansionPanel>((item) {
                return ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Text(
                        item.headerText,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    );
                  },
                  body: Column(
                    children: item.children.map<Widget>((child) {
                      if (child == 'Change Workout Selection') {
                        return ListTile(
                          title: Text(child),
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => WorkoutSelection()),
                            );
                          },
                        );
                      } else if (child == 'Workout History') {
                        return ListTile(
                          title: Text(child),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => WorkoutHistory()),
                            );
                          },
                        );
                      } else {
                        return ListTile(
                          title: Text(child),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Text('Detailed workout plans will be coming soon.'),
                                );
                              },
                            );
                          },
                        );
                      }
                    }).toList(),
                  ),
                  isExpanded: item.isExpanded,
                );
              }).toList(),
            ),
            Padding(
  padding: const EdgeInsets.all(8.0),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Recommended Videos',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VideosPage(),
              ),
            );
            },
            child: Text(
              'View All',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 8.0),
      Container(
        color: Colors.blue,
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/ytcadence.jpg',
              width: 150,
              height: 150,
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
        alignment: Alignment.center,
        child: Text(
          'Watch Now',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
        FeatherIcons.arrowLeft,
        color: Colors.yellow,
        size: 32.0,
      ),
                          onPressed: () {
                            launch('https://www.youtube.com/watch?v=eacl52qzr4E');
                          },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const ProfileList(),
          ],
        ),
      ),
    ),
  ],
),


      ),
    );
  }
}

class ExpansionPanelItem {
  final String headerText;
  final List<String> children;
  bool isExpanded;

  ExpansionPanelItem({
    required this.headerText,
    required this.children,
    required this.isExpanded,
  });
}


    