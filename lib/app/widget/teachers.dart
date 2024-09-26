import 'package:albus/routes.dart';
import 'package:flutter/material.dart';

class Teachers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextButton(
            onPressed: () => 
              Navigator.pushNamed(context, Routes.descriptionTeacher), 
            child: Text('description')),
          TextButton(
            onPressed: () => 
              Navigator.pushNamed(context, Routes.formTeacher),
            child: Text('Form')), 
        ],
      ),
    );
  }
}
