import 'package:bmitracker/log_screen.dart';
import 'package:flutter/material.dart';
import 'package:bmitracker/bmi_input_form.dart';

void main() => runApp(MyApp());

/// Main app widget.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Tracker',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        scaffoldBackgroundColor: Colors.grey[300],
        buttonColor: Colors.lightGreen,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BMIScreen()
    );
  }
}

class BMIScreen extends StatefulWidget {
  @override
  createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    BMIInputForm(),
    LogScreen()
  ];

  static const List<String> _appBarTitles = [
    'BMI Tracker',
    'Progress Log'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('${_appBarTitles.elementAt(_selectedIndex)}')),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Calculator')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text('Log')
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.lightGreen,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}