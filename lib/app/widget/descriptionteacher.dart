import 'package:flutter/material.dart';

class DescriptionTeacher extends StatelessWidget {
  @override
  Widget build (BuildContext context){
    return Container(
      child: TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text('Lista')
      )
    );
  }
}