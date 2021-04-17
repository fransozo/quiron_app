import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<String> signInWithEmailAndPassword(String email, String password);
  Future<String> createUserWithEmailAndPassword(String email, String password);
  Future<String> currentUser();
}

class Auth implements BaseAuth {
  @override
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    UserCredential usuario = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return usuario.user.uid;
  }

  @override
  Future<String> createUserWithEmailAndPassword(
      String email, String password) async {
    UserCredential usuario = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return usuario.user.uid;
  }

  @override
  Future<String> currentUser() async {
    User usuario = FirebaseAuth.instance.currentUser;
    return usuario.uid;
  }

  @override
  Future<void> signOut() async {
    return FirebaseAuth.instance.signOut();
  }
}
