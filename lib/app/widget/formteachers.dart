import 'package:albus/app/database/sqlite/dao_teacher.dart';
import 'package:albus/dominio/dto/dto_teacher.dart';
import 'package:flutter/material.dart';

class classFormTeachers extends StatefulWidget {
  @override
  _classFormTeachersState createState() => _classFormTeachersState();
}

class _classFormTeachersState extends State<classFormTeachers> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cpfController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _cpfController.dispose();
    super.dispose();
  }

  Future<void> _saveTeacher() async {
    if (_formKey.currentState!.validate()) {
      final teacher = DTOTeacher(
        name: _nameController.text,
        password: _passwordController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        cpf: _cpfController.text,
      );

      final dao = DaoTeacher();
      await dao.save(teacher);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Professor salvo com sucesso!')),
      );

      // Limpar os campos do formulário
      _nameController.clear();
      _passwordController.clear();
      _emailController.clear();
      _phoneController.clear();
      _cpfController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Professor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Senha'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a senha';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Telefone'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o telefone';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _cpfController,
                decoration: InputDecoration(labelText: 'CPF'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o CPF';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveTeacher,
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}