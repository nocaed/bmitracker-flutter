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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('BMI Tracker')),
      ),
      body: BMIInputForm(),
    );
  }
}