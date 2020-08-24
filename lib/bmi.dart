import 'dart:math';

import 'package:flutter/material.dart';
/// This is a library meant to calculate a person's BMI.

/// This is an enum meant to configure the calculation mode of the BMI based
/// on the units of measurement given.
enum BMIUnit {
  metric,
  customary
}

/// This class takes either customary or metric units and calculates a user's
/// bmi when the calculate function is called.
class BMICalculator {
  // The unit of measurement, either customary or metric.
  BMIUnit _unit;
  // A static multiplier for if the given weight is in customary units.
  static const _poundMultiplier = 703.0;

  /// Default constructor for BMICalculator, takes in a mandatory BMIUnit.
  BMICalculator(this._unit);

  /// Calculates a person's BMI based on the given weight, height, and
  /// BMIUnit given upon instanciation.
  double calculate(double weight, double height) {
    // squares the given height for the final formula
    var newHeight = pow(height, 2);
    // converts the weight to the proper units for calculation
    var newWeight = _unit == BMIUnit.customary ? weight * _poundMultiplier : weight;
    return newWeight / newHeight;
  }
}

class BMIAdviceInfo {
  String bmi;
  MaterialColor bmiColor;
  String advice;

  BMIAdviceInfo(this.bmi, this.bmiColor, this.advice);
}