import 'package:flutter/material.dart';
import 'text_field_container.dart';
import 'Firebase/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'perfil_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'constants.dart';

class LoginPage extends StatefulWidget {
  LoginPage({this.auth, this.onSignedIn});
  final BaseAuth auth;
  final VoidCallback onSignedIn;
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

enum FormType { login, register }

class _LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();
  String _email;
  String _password;
  FormType _formType = FormType.login;

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        if (_formType == FormType.login) {
          final user = await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: _email, password: _password);
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return PerfilScreen();
          }));
        } else {
          final newUser = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: _email, password: _password);
          FirebaseFirestore.instance.collection('usuarios').add(
            {'emailUser': _email, 'qtd_perfil': "0"},
          );
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return PerfilScreen();
          }));
        }
        widget.onSignedIn;
      } catch (e) {
        print("Error: $e");
      }
    }
  }

  void moveToRegister() {
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          centerTitle: true,
          title: Text(
            'Quiron',
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
                  child: Column(children: buildInputs() + buildSubmitButtons()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildInputs() {
    return [
      Image.asset("images/quiron_logo.png", width: 220, height: 220),
      Center(
        child: TextFieldContainer(
          decoration: BoxDecoration(
            color: kPrimaryLightColor,
            borderRadius: BorderRadius.circular(29),
          ),
          child: TextFormField(
            validator: (value) =>
                value.isEmpty ? "Favor preencher um endereço de E-mail" : null,
            onSaved: (value) => _email = value,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Email",
              icon: Icon(
                Icons.person,
                color: Color(0xFF15EBC4),
              ),
            ),
          ),
        ),
      ),
      Center(
        child: TextFieldContainer(
          decoration: BoxDecoration(
            color: kPrimaryLightColor,
            borderRadius: BorderRadius.circular(29),
          ),
          child: TextFormField(
            validator: (value) =>
                value.isEmpty ? "Favor preencher a senha" : null,
            onSaved: (value) => _password = value,
            obscureText: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Senha",
              icon: Icon(
                Icons.lock,
                color: Color(0xFF15EBC4),
              ),
            ),
          ),
        ),
      ),
    ];
  }

  List<Widget> buildSubmitButtons() {
    Size size = MediaQuery.of(context).size;
    if (_formType == FormType.login) {
      return [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 1, vertical: 5),
          width: size.width * 0.8,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(29),
            child: TextButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color(0xFF15EBC4),
                  ),
                ),
                onPressed: validateAndSubmit,
                child: Text("Entrar",
                    style: TextStyle(fontSize: 30.0, color: Colors.white))),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 1),
          width: size.width * 0.8,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(29),
            child: TextButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                  ),
                ),
                onPressed: moveToRegister,
                child: Text("Criar uma Conta",
                    style: TextStyle(fontSize: 20.0, color: Colors.black54))),
          ),
        ),
      ];
    } else {
      return [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 1, vertical: 5),
          width: size.width * 0.8,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(29),
            child: TextButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color(0xFF15EBC4),
                  ),
                ),
                onPressed: validateAndSubmit,
                child: Text("Cadastrar",
                    style: TextStyle(fontSize: 30.0, color: Colors.white))),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 1),
          width: size.width * 0.8,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(29),
            child: TextButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                  ),
                ),
                onPressed: moveToLogin,
                child: Text("Já tenho uma conta",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20.0, color: Colors.black54))),
          ),
        ),
      ];
    }
  }
}
