import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/widgets.dart';

class LoginContainer1 extends StatelessWidget {
  final Widget child;
  const LoginContainer1({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          LoginContainer2(),
          SafeArea(
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 10),
              child: Icon(
                Icons.person_pin_rounded,
                color: Colors.white,
                size: 100,
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
