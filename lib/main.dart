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
      home: BMIInputForm()
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

  /// Calculates the correct advice settings to give based on the current state.
  BMIAdviceInfo _advice() {
    String bmi;
    String advice;
    MaterialColor bmiColor;

    if(_currentBMI < 18.5) {
      bmi = 'Underweight';
      bmiColor = Colors.blue;
      advice = 'You are below a healthy weight. You need to consume more calories.';
    } else if(_currentBMI >= 18.5 && _currentBMI <= 24.9) {
      bmi = 'Normal';
      bmiColor = Colors.green;
      advice = 'Congratulations! You are at a healthy weight.';
    } else if(_currentBMI > 24.9 && _currentBMI <= 29.9) {
      bmi = 'Overweight';
      bmiColor = Colors.yellow;
      advice = 'You are above a healthy weight. You need to watch your diet and exercise, or you will become obese.';
    } else {
      bmi = 'Obese';
      bmiColor = Colors.red;
      advice = 'You are extremely overweight. You need to take drastic measures now, or medical intervention will be required.';
    }

    return BMIAdviceInfo(bmi, bmiColor, advice);
  }

  /// This function builds a textformfield that only takes valid doubles as input.
  Widget _buildNumberField(bool isWeight) {
    return Padding(
      child: TextFormField(
        validator: (value) => value.isEmpty || value.contains(',') ? 'Please enter a valid decimal.' : null,
        decoration: InputDecoration(
            labelText: 'Enter your ${isWeight ? "weight (${_selectedUnit == BMIUnit.customary ? "lbs" : "kg"})" : "height (${_selectedUnit == BMIUnit.customary ? "in" : "m"})"}',
            hintText: 'Enter a number.'
        ),
        keyboardType: TextInputType.number,
        controller: isWeight ? _weightController : _heightController,
      ),
      padding: EdgeInsets.all(8.0),
    );
  }

  /// Builds a button that calculates BMI.
  Widget _buildCalculateButton() {
    return RaisedButton(
      child: Text('Calculate BMI'),
      onPressed: () {
        if(_formKey.currentState.validate()) {
          var calculator = BMICalculator(_selectedUnit);
          setState(() {
            _currentWeight = double.parse(_weightController.text);
            _currentBMI = calculator.calculate(_currentWeight, double.parse(_heightController.text));
            _formKey.currentState.save();
          });
        }
      },
    );
  }

  /// Builds the radio buttons for selecting the units of measurement.
  Widget _buildRadioUnitGroup() {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text('Customary'),
          leading: Radio(
            value: BMIUnit.customary,
            groupValue: _selectedUnit,
            onChanged: (BMIUnit val) => setState(() => _selectedUnit = val),
          ),
        ),
        ListTile(
            title: Text('Metric'),
            leading: Radio(
              value: BMIUnit.metric,
              groupValue: _selectedUnit,
              onChanged: (BMIUnit val) => setState(() => _selectedUnit = val),
            )
        )
      ],
    );
  }

  /// Pushes a new screen onto the navigator that displays advice based on the
  /// user's BMI.
  void _pushAdviceScreen() {
    var settings = _advice();

    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => Scaffold(
                appBar: AppBar(
                  title: Text('Advice'),
                ),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ClipRRect(
                        child: Image.asset('assets/bmi.png'),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          settings.bmi,
                          style: TextStyle(
                              color: settings.bmiColor,
                              fontSize: 36
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(settings.advice)
                      ),
                    ],
                  ),
                )
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('BMI Calculator')),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildNumberField(true),
              _buildNumberField(false),
              _buildRadioUnitGroup(),
              _buildCalculateButton(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Your BMI: $_currentBMI'),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _pushAdviceScreen(),
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}