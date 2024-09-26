import 'package:albus/routes.dart';
import 'package:flutter/material.dart';
import 'package:albus/app/widget/teachers.dart';
import 'package:albus/app/widget/formteacher.dart';
import 'package:albus/app/widget/descriptionteacher.dart';  

class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Aulas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.cyan),
      routes:{
        Routes.home : (context) => Teachers(),
        Routes.formTeacher : (context) => FormTeacher(),
        Routes.descriptionTeacher : (context) => DescriptionTeacher(),
      },);
  }
}