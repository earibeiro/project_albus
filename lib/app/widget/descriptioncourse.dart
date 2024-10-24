import 'package:flutter/material.dart';
import 'package:albus/dominio/dto/dto_course.dart';

class DescriptionCourse extends StatelessWidget {
  final DTOCourse course;

  DescriptionCourse({required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Descrição do Curso'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Nome: ${course.name}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Duração: ${course.duration} horas',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Gratuito: ${course.isFree ? "Sim" : "Não"}',
              style: TextStyle(fontSize: 18),
            ),
            if (!course.isFree)
              SizedBox(height: 10),
              Text(
                'Preço: R\$ ${course.price.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18),
              ),
          ],
        ),
      ),
    );
  }
}