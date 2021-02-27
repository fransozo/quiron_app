import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'background_ficha_perfil.dart';
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
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: <Widget>[
                RoundedInputField(
                  hintText: "Your Email",
                  onChanged: (value) {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
