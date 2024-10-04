import 'package:flutter/material.dart';

class StudentsOptions extends StatelessWidget {
  Widget createButton(BuildContext context, String route, String label) {
    return TextButton(
      onPressed: () => Navigator.pushNamed(context, route), 
      child: Text(label));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Students Options'),
      ),
      body: ListView(
        children: [
          createButton(context, '/students', 'Students'),
          createButton(context, '/formStudents', 'Form Student'),
        ],
      ),
    );
  }
}