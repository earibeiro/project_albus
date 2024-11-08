import 'package:flutter/material.dart';
import 'package:albus/dominio/dto/dto_student.dart';
import 'package:albus/app/application/a_student.dart';

class FormStudents extends StatefulWidget {
  @override
  _FormStudentsState createState() => _FormStudentsState();
}

class _FormStudentsState extends State<FormStudents> {
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
      final DTOStudent? student = ModalRoute.of(context)!.settings.arguments as DTOStudent?;
      if (student != null) {
        _nameController.text = student.name ?? '';
        _emailController.text = student.email ?? '';
        _phoneController.text = student.phone ?? '';
        _cpfController.text = student.cpf ?? '';
        _passwordController.text = student.password ?? '';
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

  void _saveStudent() async {
    if (_formKey.currentState!.validate()) {
      DTOStudent student = DTOStudent(
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        cpf: _cpfController.text,
        password: _passwordController.text,
      );
      AStudent aStudent = AStudent();
      if (ModalRoute.of(context)!.settings.arguments == null) {
        await aStudent.save(student);
      } else {
        student.id = (ModalRoute.of(context)!.settings.arguments as DTOStudent).id;
        await aStudent.update(student);
      }
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Students'),
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
                onPressed: _saveStudent,
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}