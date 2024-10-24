import 'package:flutter/material.dart';

class CourseOptions extends StatelessWidget {
  Widget createButton(BuildContext context, String route, String label) {
    return TextButton(
      onPressed: () => Navigator.pushNamed(context, route), 
      child: Text(label));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course Options'),
      ),
      body: ListView(
        children: [
          createButton(context, '/courses', 'Courses'),
          createButton(context, '/formCourse', 'Form Course'),
        ],
      ),
    );
  }
}