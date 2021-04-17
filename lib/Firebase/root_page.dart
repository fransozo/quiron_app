import 'package:flutter/material.dart';
import 'auth.dart';
import '../tela_login.dart';
import '../perfil_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RootPage extends StatefulWidget {
  RootPage({this.auth});
  final BaseAuth auth;
  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

enum AuthStatus { notSignedIn, signedIn }

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.notSignedIn;

  @override
  initState() {
    super.initState();
    User usuario = FirebaseAuth.instance.currentUser;
    usuario?.reload();
    usuario = FirebaseAuth.instance.currentUser;

    if (usuario != null) {
      setState(() {
        authStatus = AuthStatus.signedIn;
      });
    } else
      setState(() {
        authStatus = AuthStatus.notSignedIn;
      });
  }

  void _signedIn() {
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notSignedIn:
        return new LoginPage(onSignedIn: _signedIn);
      case AuthStatus.signedIn:
        return PerfilScreen();
    }
    return null;
  }
}
