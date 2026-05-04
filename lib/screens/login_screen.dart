import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/login/login_area_form.dart';
import '../widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginContainer1(
        child: LoginAreaForm(
          textTile: 'Login',
          textButton: 'Acceder',
          pathButton: 'home',
          loginRegister: 1,
          textFinalButton: 'No tienes una cuenta?, registrate',
          path: 'register',
        ),
      ),
    );
  }
}
