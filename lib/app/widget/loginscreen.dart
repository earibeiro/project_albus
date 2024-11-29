import 'package:flutter/material.dart';
import 'package:albus/app/application/a_teacher.dart';
import 'package:albus/app/application/a_student.dart';
import 'package:albus/dominio/dto/dto_teacher.dart';
import 'package:albus/dominio/dto/dto_student.dart';
import 'package:albus/routes.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _login() async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;

      ATeacher aTeacher = ATeacher();
      AStudent aStudent = AStudent();

      DTOTeacher? teacher = await aTeacher.login(email, password);
      DTOStudent? student = await aStudent.login(email, password);

      if (teacher != null && student != null) {
        Navigator.pushReplacementNamed(context, Routes.selectionScreen);
      } else if (teacher != null) {
        Navigator.pushReplacementNamed(context, Routes.teacherProfile, arguments: teacher);
      } else if (student != null) {
        Navigator.pushReplacementNamed(context, Routes.studentsOptions);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login falhou. Verifique suas credenciais.')),
        );
      }
    }
  }

  void _navigateToRegister() {
    Navigator.pushNamed(context, Routes.signup);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Email',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira o email';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Senha',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: 'Senha',
                      border: InputBorder.none,
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira a senha';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _login,
                  child: Text('Login'),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: _navigateToRegister,
                  child: Text('Cadastre-se'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}