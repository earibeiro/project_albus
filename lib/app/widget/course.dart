import 'package:flutter/material.dart';
import 'package:albus/dominio/course.dart';
import 'package:albus/app/database/sqlite/dao_course.dart';
import 'package:albus/app/widget/formcourse.dart';
import 'package:albus/dominio/dto/dto_course.dart';

class CoursePage extends StatefulWidget {
  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  late Future<List<DTOCourse>> _courses;

  @override
  void initState() {
    super.initState();
    _loadCourses();
  }

  void _loadCourses() {
    final daoCourse = DaoCourse();
    setState(() {
      _courses = daoCourse.list();
    });
  }

  void _navigateToForm([Course? course]) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FormCourse(course: course),
      ),
    );
    _loadCourses();
  }

  void _deleteCourse(dynamic id) async {
    final daoCourse = DaoCourse();
    await daoCourse.remove(id);
    _loadCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cursos'),
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
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteCourse(course.id),
                  ),
                  onTap: () => _navigateToForm(Course(dto: course, dao: DaoCourse())),
                );
              },
            );
          }
        },
      ),
    );
  }
}