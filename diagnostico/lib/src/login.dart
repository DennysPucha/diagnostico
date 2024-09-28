import 'package:diagnostico/src/api/api.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
   LoginState createState() => LoginState();
}


class LoginState extends State<Login> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

 @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _sendData() async {
    Api.login(_emailController.text, _passwordController.text).then((response){
      final Map<String, dynamic> data = json.decode(response);

      if (data['code'] == 200){
        Navigator.pushNamed(context, '/selects');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['msg']),
            duration: const Duration(seconds: 2),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['msg']),
            duration: const Duration(seconds: 2),
          ),
        );
      }

    });
}

 @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Container(
          height: screenSize.height * 0.9,
          width: screenSize.width * 0.8,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Container(
              margin: const EdgeInsets.all(40),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Form(
                key: _formKey,
                child: Column (
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      'Iniciar Sesión',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 20), 

                   TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Correo',
                      hintText: 'Ingrese su correo',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20), 

                   TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Contraseña',
                      hintText: 'Ingrese su contraseña',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 30),

                  Center(
                    child: ElevatedButton(
                      onPressed: _sendData,
                      child: const Text('Iniciar Sesión'),
                    ),
                  ),
                ],
                )
              ),
            ),
          ),
        ),
      ),
    );
  }

}
