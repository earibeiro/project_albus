import 'package:flutter/material.dart';
import 'package:albus/dominio/dto/dto_course.dart';

class Dashboard extends StatefulWidget {
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
    setState(() {
      _courseCount = Future.value(10); 
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
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