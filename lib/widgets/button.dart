import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String textButton;
  final String pathButton;

  const Button({super.key, required this.textButton, required this.pathButton});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: SizedBox(
        width: double.infinity,
        child: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          disabledColor: Colors.blueGrey,
          color: Color.fromARGB(255, 41, 112, 148),
          elevation: 10,
          onPressed: () => Navigator.pushNamed(context, pathButton),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80, vertical: 30),
            child: Text(textButton, style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
