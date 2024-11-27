import 'package:flutter/material.dart';
import 'package:albus/dominio/dto/dto_course.dart';
import 'package:albus/app/application/a_course.dart';

class FormCourse extends StatefulWidget {
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final DTOCourse? course = ModalRoute.of(context)!.settings.arguments as DTOCourse?;
      if (course != null) {
        _nameController.text = course.name ?? '';
        _durationController.text = course.duration.toString();
        _isFree = course.isFree;
        _priceController.text = course.price.toString();
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _durationController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _saveCourse() async {
    if (_formKey.currentState!.validate()) {
      DTOCourse course = DTOCourse(
        name: _nameController.text,
        duration: int.parse(_durationController.text),
        isFree: _isFree,
        price: _isFree ? 0.0 : double.parse(_priceController.text),
      );
      ACourse aCourse = ACourse();
      if (ModalRoute.of(context)!.settings.arguments == null) {
        await aCourse.save(course);
      } else {
        course.id = (ModalRoute.of(context)!.settings.arguments as DTOCourse).id;
        await aCourse.update(course);
      }
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Course'),
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