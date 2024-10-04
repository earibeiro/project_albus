import 'package:albus/dominio/dto/dto_student.dart';
import 'package:flutter/material.dart';

class Students extends StatelessWidget {
  Future<List<DTOStudent>> save() async {
    return [
      DTOStudent(
        name: 'Adonis Albuquerque', cpf: '444.444.444-44', email: 'adalb@example.com', password: '123456789', phone: '99999-9999'),
      DTOStudent(
        name: 'Bianca Barbosa', cpf: '555.555.555-55', email: 'bibi@example.com', password: '987654321'),
      DTOStudent(
        name: 'Carlos Cunha', cpf: '666.666.666-66', email: 'cacu@example.com', password: 'abcdefgh'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Students'),
      ),
      body: FutureBuilder<List<DTOStudent>>(
        future: save(),
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
                  title: Text(student.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (student.email != null) Text('Email: ${student.email}'),
                      if (student.phone != null) Text('Phone: ${student.phone}'),
                    ],
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