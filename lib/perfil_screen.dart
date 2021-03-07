import 'package:flutter/material.dart';
import 'tela_add_perfil.dart';
import 'tela_login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PerfilScreen extends StatefulWidget {
  @override
  _PerfilScreen createState() => _PerfilScreen();
}

class _PerfilScreen extends State<PerfilScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User user;
  bool isloggedin = false;

  checkAuthentification() async {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => TelaLogin()));
      }
    });
  }

  getUser() {
    User firebaseUser = _auth.currentUser;
    firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        this.isloggedin = true;
      });
    }
  }

  signOut() async {
    _auth.signOut();
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
    this.getUser();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          centerTitle: true,
          title: Text(
            'Perfis',
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
      body: Center(
        child: !isloggedin
            ? CircularProgressIndicator()
            : Container(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return TelaAddPerfil();
                      }),
                    );
                  },
                  child: ReusableCard(
                    cor: Color(0xff15EBC4),
                  ),
                ),
                margin: EdgeInsets.all(50.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[300],
                        spreadRadius: 4,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      )
                    ],
                    color: Color(0xFF15EBC4)),
                width: 100.0,
                height: 100.0,
              ),
      ),
    );
  }
}

class ReusableCard extends StatelessWidget {
  ReusableCard({@required this.cor, this.cardChild});

  final Color cor;
  final Widget cardChild;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(Icons.person_add, color: Color(0xffC7F0E9), size: 74.0),
      // margin: EdgeInsets.all(15.0),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(5.0),
      //   color: cor,
      // ),
    );
  }
}
