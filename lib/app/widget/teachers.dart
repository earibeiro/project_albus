import 'package:albus/dominio/dto/dto_teacher.dart';
import 'package:albus/routes.dart';
import 'package:flutter/material.dart';
import 'package:albus/app/application/a_teacher.dart';
import 'package:albus/app/widget/formteachers.dart';
import 'descriptionteacher.dart';

class Teachers extends StatelessWidget {
  Future<List<DTOTeacher>> list() async {
    ATeacher aTeacher = ATeacher();
    return await aTeacher.list();
  }

  Widget createButton(BuildContext context, String route, String label) {
    return TextButton(
      onPressed: () => Navigator.pushNamed(context, route), 
      child: Text(label));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Professores'),
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DescriptionTeacher(
                          name: teacher.name ?? 'No Name',
                          email: teacher.email ?? 'No Email',
                          phone: teacher.phone ?? 'No Phone',
                          cpf: teacher.cpf ?? 'No CPF',
                          password: teacher.password ?? 'No Password',
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
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => classFormTeachers()),
          );

          (context as Element).reassemble();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}