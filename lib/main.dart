import 'package:flutter/material.dart';
import 'package:individualactivity2/screens/home.dart';
import 'package:individualactivity2/screens/add.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Retro Navigation Example',
      theme: ThemeData(
        // Apply a retro color scheme
        primaryColor: Color(0xFFDFB13E), // Mustard yellow
        scaffoldBackgroundColor: Color.fromARGB(255, 59, 182, 18), // Soft beige
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'Bungee', // Retro font
            ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Post(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: _selectedIndex == 0 ? Color(0xFFDFB13E) : Colors.grey),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add, color: _selectedIndex == 1 ? Color(0xFFDFB13E) : Colors.grey),
            label: 'Add',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFFDFB13E), // Mustard yellow for selected item
        unselectedItemColor: Colors.grey, // Grey for unselected items
        backgroundColor: Color(0xFF0A3442), // Teal background for BottomNavigationBar
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed, // Ensures labels are always visible
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedLabelStyle: TextStyle(
          fontFamily: 'Bungee',
          fontSize: 14,
        ),
      ),
    );
  }
}
