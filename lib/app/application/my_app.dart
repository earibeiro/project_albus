import 'package:albus/routes.dart';
import 'package:flutter/material.dart';
import 'package:albus/app/widget/selectionscreen.dart';
import 'package:albus/app/widget/studentsoptions.dart';
import 'package:albus/app/widget/students.dart';
import 'package:albus/app/widget/formstudents.dart';
import 'package:albus/app/widget/teachersoptions.dart';
import 'package:albus/app/widget/formteachers.dart';
import 'package:albus/app/widget/descriptionteacher.dart';
import 'package:albus/app/widget/teachers.dart';
import 'package:albus/app/widget/course.dart';
import 'package:albus/app/widget/courseoptions.dart';
import 'package:albus/app/widget/formcourse.dart';
import 'package:albus/app/widget/descriptioncourse.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aulas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.cyan),
      routes: {
        Routes.home: (context) => SelectionScreen(),
        Routes.studentsOptions: (context) => StudentsOptions(),
        Routes.students: (context) => Students(),
        Routes.formStudents: (context) => FormStudents(),
        Routes.teachers: (context) => Teachers(),
        Routes.formTeacher: (context) => FormTeachers(),
        Routes.teachersOptions: (context) => TeachersOptions(),
        Routes.course: (context) => CoursePage(),
        Routes.courseOptions: (context) => CourseOptions(),
        Routes.formCourse: (context) => FormCourse(),
        Routes.descriptionCourse: (context) => DescriptionCourse(course: ModalRoute.of(context)!.settings.arguments),
        Routes.descriptionTeacher: (context) => DescriptionTeacher(teacher: ModalRoute.of(context)!.settings.arguments),
      },
    );
  }
}