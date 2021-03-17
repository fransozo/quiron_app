import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'already_have_an_account_acheck.dart';
import 'rounded_button.dart';
import 'text_field_container.dart';
import 'perfil_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'constants.dart';

class TelaLogin extends StatefulWidget {
  @override
  _TelaLogin createState() => _TelaLogin();
}

class _TelaLogin extends State<TelaLogin> {
  final _auth = FirebaseAuth.instance;
  final formKey = new GlobalKey<FormState>();

  String email;
  String pass;

  void validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      print("Formulário Válido");
    } else {
      print("Formulário Inválido");
    }
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          centerTitle: true,
          title: Text(
            'Login',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 36,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Color(0xFF0FA086),
                    offset: Offset(5.0, 5.0),
                  ),
                ],
                fontFamily: 'Monda'),
          ),
          elevation: 5,
          flexibleSpace: Image(
            image: AssetImage('images/appbar.png'),
            fit: BoxFit.cover,
          ),
          backgroundColor: Colors.transparent,
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        "images/quiron_logo.png",
                        width: 250,
                        height: 200,
                      ),
                      SizedBox(height: size.height * 0.03),
                      SizedBox(height: size.height * 0.03),
                      TextFieldContainer(
                        child: TextFormField(
                          validator: (value) => value.isEmpty
                              ? "Favor inserir um endereço de e-mail"
                              : null,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              color: Colors.black54, fontFamily: 'Monda'),
                          onChanged: (value) {
                            email = value;
                          },
                          cursorColor: kPrimaryColor,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.person,
                              color: kPrimaryColor,
                            ),
                            hintText: "E-mail",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      TextFieldContainer(
                        child: TextFormField(
                          validator: (value) =>
                              value.isEmpty ? "Favor preencher a senha" : null,
                          obscureText: true,
                          style: TextStyle(
                              color: Colors.black54, fontFamily: 'Monda'),
                          onChanged: (value) {
                            pass = value;
                          },
                          cursorColor: kPrimaryColor,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.lock,
                              color: kPrimaryColor,
                            ),
                            hintText: "Senha",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      RoundedButton(
                        text: "Entrar",
                        press: () {
                          validateAndSave();

                          // try {
                          //   final user = await _auth.signInWithEmailAndPassword(
                          //       email: email, password: pass);
                          //   if (user != null) {
                          //     Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //         builder: (context) {
                          //           return PerfilScreen();
                          //         },
                          //       ),
                          //     );
                          //   }
                          // } catch (e) {
                          //   print(e);
                          // }
                        },
                      ),
                      SizedBox(height: size.height * 0.03),
                      AlreadyHaveAnAccountCheck(
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return SignUpScreen();
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
