import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../global.dart';

class SignUpCheck extends StatelessWidget {
  final bool login;
  final VoidCallback press;
  const SignUpCheck({
    Key? key,
    this.login = true,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          login ? "Don't have an account ? " : "Already have an account ? ",
          style: GoogleFonts.montserrat(color: color1),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "Sign Up" : "Sign In",
            style: GoogleFonts.montserrat(
              color: color1,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
