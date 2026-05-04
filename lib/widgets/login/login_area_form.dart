import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/login_form_provider.dart';
import 'package:flutter_application_1/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginAreaForm extends StatelessWidget {
  final String textTile;
  final String textButton;
  final String pathButton;
  final int loginRegister;
  final String textFinalButton;
  final String path;

  const LoginAreaForm({
    super.key,
    required this.textTile,
    required this.textButton,
    required this.pathButton,
    required this.loginRegister,
    required this.textFinalButton,
    required this.path,
  });
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 150),
          CardContainer(
            child: Column(
              children: [
                SizedBox(height: 10),
                Text(
                  textTile,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                SizedBox(height: 10),
                ChangeNotifierProvider(
                  create: (_) => LoginFormProvider(),
                  child: LoginForm(
                    textButton: textButton,
                    pathButton: pathButton,
                    loginRegister: loginRegister,
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, path),
                  child: Text(textFinalButton),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
