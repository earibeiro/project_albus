import 'package:flutter/material.dart';
import 'package:albus/routes.dart';

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  Widget createButton(BuildContext context, String route, String label) {
    return ElevatedButton(
      onPressed: () => Navigator.pushNamed(context, route), 
      child: Text(label),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selection'),
      ),
      body: ListView(
        children: [
          createButton(context, Routes.studentsOptions, 'Students Options'),
          createButton(context, Routes.teachersOptions, 'Teachers Options'),
        ],
      ),
    );
  }
}