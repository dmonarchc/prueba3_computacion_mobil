import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formkey = new GlobalKey<FormState>();

  String email = '';
  String password = '';
  bool _isLoading = false;

  bool get isloading => _isLoading;

  set isloading(bool value) {
    _isLoading = value;
  }

  bool isValidForm() {
    return formkey.currentState?.validate() ?? false;
  }
}
