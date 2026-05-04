import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/input_decorations.dart';
import 'package:provider/provider.dart';

import '../../providers/login_form_provider.dart';
import '../../services/services.dart';

class LoginForm extends StatelessWidget {
  final String textButton;
  final String pathButton;
  final int loginRegister;

  const LoginForm({
    super.key,
    required this.textButton,
    required this.pathButton,
    required this.loginRegister,
  });

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Form(
      key: loginForm.formkey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
              hinText: 'Ingrese su correo',
              labelText: 'Email',
              prefixIcon: Icons.people,
            ),
            onChanged: (value) => loginForm.email = value.trim(),
            validator: (value) {
              return (value != null && value.length > 4)
                  ? null
                  : 'Ingrese un correo válido';
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.text,
            decoration: InputDecorations.authInputDecoration(
              hinText: '**********',
              labelText: 'Password',
              prefixIcon: Icons.lock_outline,
            ),
            onChanged: (value) => loginForm.password = value,
            validator: (value) {
              return (value != null && value.length >= 6)
                  ? null
                  : 'La contraseña debe tener al menos 6 caracteres';
            },
          ),
          const SizedBox(height: 20),

          if (loginRegister == 1)
            TextButton(
              onPressed: () async {
                final email = loginForm.email.trim();

                if (email.isEmpty || email.length < 5) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Ingrese su correo primero')),
                  );
                  return;
                }

                final authService = Provider.of<AuthServices>(
                  context,
                  listen: false,
                );

                final errorMessage = await authService.resetPassword(email);

                if (errorMessage == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Correo de recuperación enviado a $email'),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: $errorMessage')),
                  );
                }
              },
              child: const Text('¿Olvidaste tu contraseña?'),
            ),

          const SizedBox(height: 10),

          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            disabledColor: Colors.grey,
            color: Colors.blueGrey,
            elevation: 0,
            onPressed: loginForm.isloading
                ? null
                : () async {
                    FocusScope.of(context).unfocus();

                    final authService = Provider.of<AuthServices>(
                      context,
                      listen: false,
                    );

                    if (!loginForm.isValidForm()) return;

                    loginForm.isloading = true;

                    if (loginRegister == 1) {
                      final String? errorMessage = await authService.login(
                        loginForm.email,
                        loginForm.password,
                      );

                      if (errorMessage == null) {
                        Navigator.pushReplacementNamed(context, pathButton);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: $errorMessage')),
                        );
                      }
                    } else {
                      final String? errorMessage = await authService.createUser(
                        loginForm.email,
                        loginForm.password,
                      );

                      if (errorMessage == null) {
                        Navigator.pushReplacementNamed(context, pathButton);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: $errorMessage')),
                        );
                      }
                    }

                    loginForm.isloading = false;
                  },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
              child: Text(
                textButton,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
