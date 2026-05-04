import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/login/login_area_form.dart';
import '../widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginContainer1(
        child: LoginAreaForm(
          textTile: 'Registro',
          textButton: 'Registrar',
          pathButton: 'login',
          loginRegister: 2,
          textFinalButton: 'tienes una cuenta?, accede',
          path: 'login',
        ),
      ),
    );
  }
}
