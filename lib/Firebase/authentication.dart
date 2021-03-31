import 'package:firebase_auth/firebase_auth.dart';

persist() {
  User user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    print("user");
  } else {
    print('Usuário não logado');
  }
}
