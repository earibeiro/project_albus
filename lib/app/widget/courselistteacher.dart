import 'package:flutter/material.dart';
import 'package:albus/app/application/a_course.dart';
import 'package:albus/dominio/dto/dto_course.dart';
import 'package:albus/routes.dart';
import 'formcourse.dart';
import 'descriptioncourse.dart';

class CourseListTeacher extends StatefulWidget {
  @override
  _CourseListTeacherState createState() => _CourseListTeacherState();
}

class _CourseListTeacherState extends State<CourseListTeacher> {
  late Future<List<DTOCourse>> _courses;

  @override
  void initState() {
    super.initState();
    _loadCourses();
  }

  void _loadCourses() {
    final aCourse = ACourse();
    setState(() {
      _courses = aCourse.list();
    });
  }

  void _navigateToForm([DTOCourse? course]) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FormCourse(),
        settings: RouteSettings(arguments: course),
      ),
    );
    _loadCourses();
  }

  void _deleteCourse(dynamic id) async {
    final aCourse = ACourse();
    await aCourse.remove(id);
    _loadCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Cursos'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _navigateToForm(),
          ),
        ],
      ),
      body: FutureBuilder<List<DTOCourse>>(
        future: _courses,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar cursos'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum curso encontrado'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final course = snapshot.data![index];
                return ListTile(
                  title: Text(course.name),
                  subtitle: Text('Duração: ${course.duration} horas'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _navigateToForm(course),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteCourse(course.id),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DescriptionCourse(
                          course: course,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}