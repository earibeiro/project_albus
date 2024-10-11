import 'package:albus/app/application/a_student.dart';
import 'package:albus/dominio/dto/dto_student.dart';
import 'package:flutter/material.dart';
import 'formstudents.dart';
import 'descriptionstudent.dart';

class Students extends StatelessWidget {
  Future<List<DTOStudent>> list() async {

        AStudent aStudent = AStudent();

        return await aStudent.list();
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Students'),
      ),
      body: FutureBuilder<List<DTOStudent>>(
        future: list(),
        builder: (BuildContext context, AsyncSnapshot<List<DTOStudent>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar dados'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum dado encontrado'));
          } else {
            List<DTOStudent> lista = snapshot.data!;
            return ListView.builder(
              itemCount: lista.length,
              itemBuilder: (context, index) {
                var student = lista[index];
                return ListTile(
                  leading: Icon(Icons.person),
                  title: Text(student.name ?? 'No Name'),
                  subtitle: Text(student.email ?? 'No Email'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DescriptionStudent(
                          name: student.name ?? 'No Name',
                          email: student.email ?? 'No Email',
                          phone: student.phone ?? 'No Phone',
                          cpf: student.cpf ?? 'No CPF',
                          password: student.password ?? 'No Password',
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
            MaterialPageRoute(builder: (context) => FormStudents()),
          );
          (context as Element).reassemble();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}