import 'package:flutter/material.dart';
import 'package:albus/dominio/dto/dto_teacher.dart';
import 'package:albus/app/application/a_teacher.dart';

class FormTeachers extends StatefulWidget {
  @override
  _FormTeachersState createState() => _FormTeachersState();
}

class _FormTeachersState extends State<FormTeachers> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cpfController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final DTOTeacher? teacher = ModalRoute.of(context)!.settings.arguments as DTOTeacher?;
      if (teacher != null) {
        _nameController.text = teacher.name ?? '';
        _emailController.text = teacher.email ?? '';
        _phoneController.text = teacher.phone ?? '';
        _cpfController.text = teacher.cpf ?? '';
        _passwordController.text = teacher.password ?? '';
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _cpfController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _saveTeacher() async {
    if (_formKey.currentState!.validate()) {
      DTOTeacher teacher = DTOTeacher(
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        cpf: _cpfController.text,
        password: _passwordController.text,
      );
      ATeacher aTeacher = ATeacher();
      if (ModalRoute.of(context)!.settings.arguments == null) {
        await aTeacher.save(teacher);
      } else {
        teacher.id = (ModalRoute.of(context)!.settings.arguments as DTOTeacher).id;
        await aTeacher.update(teacher);
      }
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Teachers'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _cpfController,
                decoration: InputDecoration(labelText: 'CPF'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a CPF';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveTeacher,
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}