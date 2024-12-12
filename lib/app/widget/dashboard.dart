import 'package:flutter/material.dart';
import 'package:albus/dominio/dto/dto_course.dart';
import 'package:albus/routes.dart';
import 'package:albus/dominio/dto/dto_teacher.dart';
import 'package:albus/app/application/a_course.dart';

class Dashboard extends StatefulWidget {
  final DTOTeacher teacher;

  Dashboard({required this.teacher});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late Future<int> _courseCount;
  late Future<int> _studentCount;
  late Future<DTOCourse?> _courseWithMostStudents;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    ACourse aCourse = ACourse();
    setState(() {
      _courseCount = aCourse.count();
      _studentCount = Future.value(200);
      _courseWithMostStudents = Future.value(DTOCourse(
        id: 1,
        name: 'Curso de Flutter',
        duration: 40,
        isFree: false,
        price: 199.99,
      ));
    });
  }

  void _logout() {
    Navigator.pushReplacementNamed(context, Routes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.cyan,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Cadastrar Novo Curso'),
              onTap: () {
                Navigator.pushNamed(context, Routes.formCourse);
              },
            ),
            ListTile(
              leading: Icon(Icons.book),
              title: Text('Meus Cursos'),
              onTap: () {
                Navigator.pushNamed(context, Routes.courseListTeacher);
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Perfil do Professor'),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  Routes.teacherProfile,
                  arguments: widget.teacher,
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.assignment),
              title: Text('Atividades'),
              onTap: () {
                // Navegar para a página de atividades
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: _logout,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            FutureBuilder<int>(
              future: _courseCount,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Erro ao carregar dados');
                } else {
                  return Card(
                    child: ListTile(
                      title: Text('Quantidade de Cursos'),
                      subtitle: Text(snapshot.data.toString()),
                    ),
                  );
                }
              },
            ),
            FutureBuilder<int>(
              future: _studentCount,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Erro ao carregar dados');
                } else {
                  return Card(
                    child: ListTile(
                      title: Text('Quantidade de Alunos nos Cursos'),
                      subtitle: Text(snapshot.data.toString()),
                    ),
                  );
                }
              },
            ),
            FutureBuilder<DTOCourse?>(
              future: _courseWithMostStudents,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Erro ao carregar dados');
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return Card(
                    child: ListTile(
                      title: Text('Curso com Maior Quantidade de Alunos'),
                      subtitle: Text('Nenhum curso encontrado'),
                    ),
                  );
                } else {
                  return Card(
                    child: ListTile(
                      title: Text('Curso com Maior Quantidade de Alunos'),
                      subtitle: Text(snapshot.data!.name),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}