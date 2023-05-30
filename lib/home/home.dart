import 'package:bitfit102/screens/services/auth.dart';
import 'package:flutter/material.dart';

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
          'Explore workout plans',
          'Workout History',
          'Logout',
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
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ),
        ],
      ),
      body: ListView(
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
                    return ListTile(
                      title: Text(child),
                    );
                  }).toList(),
                ),
                isExpanded: item.isExpanded,
              );
            }).toList(),
          ),
          const Center(
            child: Text(
              'Under Development',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
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
