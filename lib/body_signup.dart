import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'background_signup.dart';
import 'or_divider.dart';
import 'social_icon.dart';
import 'already_have_an_account_acheck.dart';
import 'rounded_button.dart';
import 'rounded_input_field.dart';
import 'rounded_password_field.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "images/quiron_logo.png",
              width: 250,
              height: 200,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "SIGNUP",
              press: () {},
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
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocalIcon(
                  iconSrc: "images/icons/facebook.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "images/icons/twitter.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "images/icons/google-plus.svg",
                  press: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
