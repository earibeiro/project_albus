import 'package:albus/app/widget/dashboard.dart';
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
import 'package:albus/app/widget/loginscreen.dart';
import 'package:albus/app/widget/studentloginscreen.dart';
import 'package:albus/app/widget/signup.dart';
import 'package:albus/app/widget/teacherprofilescreen.dart';
import 'package:albus/app/widget/courselistteacher.dart';
import 'package:albus/dominio/dto/dto_course.dart';
import 'package:albus/dominio/dto/dto_teacher.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aulas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.cyan),
      routes: {
        Routes.home: (context) => LoginScreen(),
        Routes.studentsOptions: (context) => StudentsOptions(),
        Routes.students: (context) => Students(),
        Routes.formStudents: (context) => FormStudents(),
        Routes.teachers: (context) => Teachers(),
        Routes.formTeachers: (context) => FormTeachers(),
        Routes.teachersOptions: (context) => TeachersOptions(),
        Routes.course: (context) => CoursePage(),
        Routes.courseOptions: (context) => CourseOptions(),
        Routes.formCourse: (context) => FormCourse(),
        Routes.descriptionCourse: (context) => DescriptionCourse(course: ModalRoute.of(context)!.settings.arguments as DTOCourse),
        Routes.descriptionTeacher: (context) => DescriptionTeacher(DTOTeacher: ModalRoute.of(context)!.settings.arguments as DTOTeacher),
        Routes.studentLogin: (context) => StudentLoginScreen(),
        Routes.signup: (context) => SignupScreen(),
        Routes.teacherProfile: (context) => TeacherProfileScreen(teacher: ModalRoute.of(context)!.settings.arguments as DTOTeacher, ),
        Routes.courseListTeacher: (context) => CourseListTeacher(),
        Routes.dashboard: (context) => Dashboard(),
      },
    );
  }
}