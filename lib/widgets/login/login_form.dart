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
            keyboardType: TextInputType.text,
            decoration: InputDecorations.authInputDecoration(
              hinText: 'Ingrese su correo',
              labelText: 'Email',
              prefixIcon: Icons.people,
            ),
            onChanged: (value) => loginForm.email = value,
            validator: (value) {
              return (value != null && value.length > 4)
                  ? null
                  : 'El usuario no puede estar vacio o ser de menos de 4 caracteres';
            },
          ),
          SizedBox(height: 30),
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
              return (value != null && value.length > 4)
                  ? null
                  : 'El usuario no puede estar vacio o ser de menos de 4 caracteres';
            },
          ),
          SizedBox(height: 30),
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(10),
            ),
            disabledColor: Colors.grey,
            color: Colors.blueGrey,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80, vertical: 10),
              child: Text(textButton, style: TextStyle(color: Colors.white)),
            ),
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
                    if (loginRegister == 1) {
                      final String? errorMessage = await authService.login(
                        loginForm.email,
                        loginForm.password,
                      );
                      if (errorMessage == null) {
                        Navigator.pushNamed(context, pathButton);
                      } else {
                        print(errorMessage);
                      }
                    } else {
                      final String? errorMessage = await authService.createUser(
                        loginForm.email,
                        loginForm.password,
                      );
                      if (errorMessage == null) {
                        Navigator.pushNamed(context, pathButton);
                      } else {
                        print(errorMessage);
                      }
                    }
                    loginForm.isloading = false;
                  },
          ),
        ],
      ),
    );
  }
}
