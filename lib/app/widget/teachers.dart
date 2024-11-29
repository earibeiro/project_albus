import 'package:albus/app/application/a_teacher.dart';
import 'package:albus/dominio/dto/dto_teacher.dart';
import 'package:flutter/material.dart';
import 'descriptionteacher.dart';
import 'package:albus/routes.dart';

class Teachers extends StatefulWidget {
  @override
  _TeachersState createState() => _TeachersState();
}

class _TeachersState extends State<Teachers> {
  late Future<List<DTOTeacher>> _teachers;

  @override
  void initState() {
    super.initState();
    _loadTeachers();
  }

  void _loadTeachers() {
    ATeacher aTeacher = ATeacher();
    setState(() {
      _teachers = aTeacher.list();
    });
  }

  void _deleteTeacher(BuildContext context, dynamic id) async {
    ATeacher aTeacher = ATeacher();
    await aTeacher.remove(id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Professor excluído com sucesso!')),
    );
    _loadTeachers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Professores'),
      ),
      body: FutureBuilder<List<DTOTeacher>>(
        future: _teachers,
        builder: (BuildContext context, AsyncSnapshot<List<DTOTeacher>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar dados'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum dado encontrado'));
          } else {
            List<DTOTeacher> lista = snapshot.data!;
            return ListView.builder(
              itemCount: lista.length,
              itemBuilder: (context, index) {
                var teacher = lista[index];
                return ListTile(
                  leading: Icon(Icons.person),
                  title: Text(teacher.name ?? 'No Name'),
                  subtitle: Text(teacher.email ?? 'No Email'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            Routes.formTeachers,
                            arguments: teacher,
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteTeacher(context, teacher.id),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DescriptionTeacher(
                          DTOTeacher: teacher,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(
            context,
            Routes.formTeachers,
          );
          _loadTeachers();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}