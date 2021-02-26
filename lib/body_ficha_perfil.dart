import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'background_signup.dart';
import 'or_divider.dart';
import 'social_icon.dart';
import 'already_have_an_account_acheck.dart';
import 'rounded_button.dart';
import 'rounded_input_field.dart';
import 'rounded_password_field.dart';

class BodyFicha extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Image.asset(
                "images/quiron_logo.png",
                width: 250,
                height: 200,
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Expanded(
              child: RoundedInputField(
                hintText: "Nome",
                onChanged: (value) {},
              ),
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
