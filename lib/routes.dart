import 'package:flutter/material.dart';
import 'package:albus/app/widget/studentsoptions.dart';
import 'package:albus/app/widget/teachersoptions.dart';
import 'package:albus/app/widget/courseoptions.dart';
import 'package:albus/app/widget/formcourse.dart';
import 'package:albus/app/widget/descriptioncourse.dart';
import 'package:albus/app/widget/selectionscreen.dart';
import 'package:albus/app/widget/students.dart';
import 'package:albus/app/widget/formstudents.dart';
import 'package:albus/app/widget/teachers.dart';
import 'package:albus/app/widget/formteachers.dart';
import 'package:albus/app/widget/descriptionteacher.dart';

class Routes {
  static const String home = '/';
  static const String teachersOptions = '/teachersOptions';
  static const String teachers = '/teachers';
  static const String descriptionTeacher = '/descriptionTeacher';
  static const String formTeachers = '/formTeachers';
  static const String studentsOptions = '/studentsOptions';
  static const String students = '/students';
  static const String formStudents = '/formStudents';
  static const String courseOptions = '/courseOptions';
  static const String course = '/course';
  static const String formCourse = '/formCourse';
  static const String descriptionCourse = '/descriptionCourse';
}