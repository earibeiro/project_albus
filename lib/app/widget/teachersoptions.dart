import 'package:flutter/material.dart';

class TeachersOptions extends StatelessWidget {
  Widget createButton(BuildContext context, String route, String label) {
    return TextButton(
      onPressed: () => Navigator.pushNamed(context, route), 
      child: Text(label));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teachers Options'),
      ),
      body: ListView(
        children: [
          createButton(context, '/teachers', 'Teachers'),
          createButton(context, '/formTeacher', 'Form Teacher'),
        ],
      ),
    );
  }
}