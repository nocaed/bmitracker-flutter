import 'package:flutter/material.dart';

class LogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('Your Progress'),),
      ),
      body: SingleChildScrollView(
        child: Text('Test'),
      ),
    );
  }
}