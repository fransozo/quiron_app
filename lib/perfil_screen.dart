import 'package:flutter/material.dart';
import 'tela_add_perfil.dart';
import 'constants.dart';
import 'tela_login.dart';
import 'tela_perfil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PerfilScreen extends StatefulWidget {
  @override
  _PerfilScreen createState() => _PerfilScreen();
}

class _PerfilScreen extends State<PerfilScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User user;
  bool isloggedin = false;

  checkAuthentification() async {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
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

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
    this.getUser();
  }

  String emailUser;
  String email;
  String idDoc;
  void getCurrentUserEmail() async {
    User emailUser = _auth.currentUser;
    email = emailUser.email;
    print("METODO GET CURRENT EMAIL $email");
  }

  getProfiles() async {
    getCurrentUserEmail();
    QuerySnapshot resultado = await _firestore
        .collection("usuarios")
        .where("emailUser", isEqualTo: "$email")
        .get();
    resultado.docs.forEach((d) {
      idDoc = d.id;
      print(d.id);
    });
  }

  Widget build(BuildContext context) {
    getProfiles();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: buildAppBar("Perfil"),
      ),
      body: Center(
        child: !isloggedin
            ? CircularProgressIndicator()
            : Column(
                children: <Widget>[
                  // PerfilCard(),
                  StreamBuilder<QuerySnapshot>(
                    stream: _firestore
                        .collection('perfil')
                        .where("id_user", isEqualTo: "$email")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Color(0xff15EBC4),
                          ),
                        );
                      }

                      final dados = snapshot.data.docs;
                      List<PerfilCard> dadosWidgets = [];
                      for (var dado in dados) {
                        final dadoName = dado.get('name_prof');
                        final dadoFamName = dado.get('fam_name_prof');
                        final dadoRG = dado.get('rg_prof');

                        final dadosWidget = PerfilCard(
                          textName: dadoName,
                          textFamName: dadoFamName,
                          textRG: dadoRG,
                        );

                        dadosWidgets.add(dadosWidget);
                      }
                      return Column(
                        children: dadosWidgets,
                      );
                    },
                  ),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return TelaAddPerfil();
              },
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0XFF15EBC4),
      ),
    );
  }
}

class PerfilCard extends StatelessWidget {
  const PerfilCard({
    this.textName,
    this.textFamName,
    this.textRG,
    Key key,
  }) : super(key: key);

  final String textName;
  final String textFamName;
  final String textRG;

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget editButton = TextButton(
      child: Text("Editar"),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PerfilScreen();
        }));
      },
    );
    Widget excluirButton = TextButton(
      child: Text("Excluir"),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PerfilScreen();
        }));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alerta"),
      content: Text("O'que deseja fazer com esse perfil ?"),
      actions: [
        editButton,
        excluirButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return TelaPerfil(rgPerfil: '$textRG');
              },
            ),
          );
        },
        onLongPress: () {
          showAlertDialog(context);
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(29.0),
          ),
          color: kPrimaryLightColor,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/images.png'),
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        // color: Colors.red,
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          "$textName $textFamName",
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text("RG: $textRG",
                          style:
                              TextStyle(color: Colors.black54, fontSize: 17.0)),
                    ],
                  ),
                )
              ],
            ),
          ),
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

AppBar buildAppBar(String texto) {
  String title = texto;
  return AppBar(
    centerTitle: true,
    title: Text(
      '$title',
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
    actions: <Widget>[
      Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
              //checkAuthentification();
            },
            child: Icon(
              Icons.logout,
              size: 26.0,
            ),
          )),
    ],
    elevation: 5,
    flexibleSpace: Image(
      image: AssetImage('images/appbar.png'),
      fit: BoxFit.cover,
    ),
    backgroundColor: Colors.transparent,
  );
}
