import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forsis/components/my_textfield.dart';
import 'package:http/http.dart' as http;
import 'package:forsis/pages/dashboard.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void _showAlertDialog(BuildContext context, String text) {
    if (text == "Success") {
      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('Inicio de Sesión'),
          content: Text(text),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              /// This parameter indicates this action is the default,
              /// and turns the action's text to bold text.
              isDefaultAction: true,
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) {
                    return LauncherPage(usernameController.text);
                  }),
                );
              },
              child: const Text('Ok'),
            ),
          ],
        ),
      );
    } else {
      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('Inicio de Sesión'),
          content: Text(text),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              /// This parameter indicates this action is the default,
              /// and turns the action's text to bold text.
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Ok'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Future singUserIn() async {
      var url = Uri.http(
          "forsis.ddns.net", '/entradasysalidas/login.php', {'q': '{http}'});
      var response = await http.post(url, body: {
        "username": usernameController.text,
        "password": passwordController.text,
      });
      var data = json.decode(response.body);
      // ignore: use_build_context_synchronously
      _showAlertDialog(context, data.toString());
    }
    //text editing controllers

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50),

              //logo
              Image.asset(
                'lib/images/logo_forsis.png',
                height: 100,
              ),

              const SizedBox(height: 50),
              //Texto de bienvenida
              Text(
                'Bienvenido',
                style: TextStyle(color: Colors.grey[700]),
              ),
              const SizedBox(height: 25),
              //username
              MyTextField(
                controller: usernameController,
                hintText: 'Usuario',
                obscureText: false,
              ),

              const SizedBox(height: 10),
              //password
              MyTextField(
                controller: passwordController,
                hintText: 'Contraseña',
                obscureText: true,
              ),

              const SizedBox(height: 10),

              //forgot password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '¿Olvidaste la contraseña?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              CupertinoButton.filled(
                onPressed: singUserIn,
                child: const Text('Iniciar Sesión'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
