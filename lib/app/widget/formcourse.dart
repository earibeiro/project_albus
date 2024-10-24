import 'package:flutter/material.dart';
import 'package:albus/dominio/dto/dto_course.dart';
import 'package:albus/dominio/course.dart';
import 'package:albus/app/database/sqlite/dao_course.dart';

class FormCourse extends StatefulWidget {
  final Course? course;

  FormCourse({this.course});

  @override
  _FormCourseState createState() => _FormCourseState();
}

class _FormCourseState extends State<FormCourse> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _durationController = TextEditingController();
  final _priceController = TextEditingController();
  bool _isFree = false;

  @override
  void initState() {
    super.initState();
    if (widget.course != null) {
      _nameController.text = widget.course!.name;
      _durationController.text = widget.course!.duration.toString();
      _isFree = widget.course!.isFree;
      _priceController.text = widget.course!.price.toString();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _durationController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _saveCourse() {
    if (_formKey.currentState!.validate()) {
      final dtoCourse = DTOCourse(
        name: _nameController.text,
        duration: int.parse(_durationController.text),
        isFree: _isFree,
        price: _isFree ? 0.0 : double.parse(_priceController.text),
      );

      final daoCourse = DaoCourse();
      final course = Course(dto: dtoCourse, dao: daoCourse);

      if (widget.course == null) {
        course.save(dtoCourse);
      } else {
        dtoCourse.id = widget.course!.id;
        course.update(dtoCourse);
      }

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.course == null ? 'Novo Curso' : 'Editar Curso'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nome do Curso'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome do curso';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _durationController,
                decoration: InputDecoration(labelText: 'Duração (horas)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a duração do curso';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Por favor, insira um número válido';
                  }
                  return null;
                },
              ),
              SwitchListTile(
                title: Text('Gratuito'),
                value: _isFree,
                onChanged: (value) {
                  setState(() {
                    _isFree = value;
                  });
                },
              ),
              if (!_isFree)
                TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(labelText: 'Preço'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o preço do curso';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Por favor, insira um número válido';
                    }
                    return null;
                  },
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveCourse,
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}