import 'package:bmitracker/bmi.dart';
import 'package:flutter/material.dart';

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
      home: Center(child: Text('Hello World'),),
    );
  }
}

/// The input form for BMI.
class BMIInputForm extends StatefulWidget {
  @override
  createState() => _BMIInputFormState();
}

// The state of the input form.
class _BMIInputFormState extends State<BMIInputForm> {
  // state variables
  // form key that manages input state
  final _formKey = GlobalKey<FormState>();
  // controller for weight input
  final _weightController = TextEditingController();
  // controller for height input
  final _heightController = TextEditingController();

  // the current bmi
  double _currentBMI;
  // the current weight
  double _currentWeight;
  // the currently selected unit of measurement
  BMIUnit _selectedUnit;

  @override
  void initState() {
    super.initState();
    _currentBMI = 0;
    _currentWeight = 0;
    _selectedUnit = BMIUnit.customary;
  }

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}