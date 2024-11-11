import 'package:albus/app/application/a_teacher.dart';
import 'package:albus/dominio/dto/dto_teacher.dart';
import 'package:flutter/material.dart';
import 'descriptionteacher.dart';
import 'package:albus/routes.dart';

class Teachers extends StatelessWidget {
  Future<List<DTOTeacher>> list() async {
    ATeacher aTeacher = ATeacher();
    return await aTeacher.list();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teachers'),
      ),
      body: FutureBuilder<List<DTOTeacher>>(
        future: list(),
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
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        Routes.formTeachers,
                        arguments: teacher,
                      );
                    },
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
          (context as Element).reassemble();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}