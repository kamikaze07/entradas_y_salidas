import 'package:flutter/material.dart';
import 'package:forsis/components/my_buttton.dart';
import 'package:forsis/components/my_textfield.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  //text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void singUserIn() {}

  @override
  Widget build(BuildContext context) {
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

              MyButton(
                buttonText: "Iniciar Sesión",
                onTap: singUserIn,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
