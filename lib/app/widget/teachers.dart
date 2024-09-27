import 'package:albus/dominio/dto/dto_teacher.dart';
import 'package:albus/routes.dart';
import 'package:flutter/material.dart';
import 'package:albus/app/application/a_teacher.dart';

class Teachers extends StatelessWidget {
  Future<List<DTOTeacher>> save() async {
    return [
      DTOTeacher(
        name: 'Roger Silva', cpf: '111.111.111-11', description: 'Geografia', email: ''),
      DTOTeacher(
        name: 'Joana Cardoso', cpf: '222.222.222-22', description: 'Matemática', email: ''),
      DTOTeacher(
        name: 'Douglas Rodrigues', cpf: '333.333.333-33', description: 'História', email: ''),
    ];
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
        title: Text('Teachers'),
      ),
      body: FutureBuilder<List<DTOTeacher>>(
        future: save(),
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
                  title: Text(teacher.name),
                  subtitle: Text(teacher.description ?? ''),
                  onTap: () => Navigator.pushNamed(
                    context, 
                    Routes.descriptionTeacher,
                    arguments: teacher
                  ),
                );
              }
            );
          }
        }
      ),
    );
  }
}