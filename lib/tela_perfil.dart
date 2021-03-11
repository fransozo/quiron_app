import 'package:flutter/material.dart';
import 'perfil_screen.dart';
import 'rounded_button.dart';
import 'constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'contact.dart';

class Background extends StatelessWidget {
  final Widget child;
  Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  final _firestore = FirebaseFirestore.instance;
  CollectionReference perfil = FirebaseFirestore.instance.collection('perfil');

  List<Contact> listaContato = <Contact>[];

  Future<dynamic> getData() async {
    CollectionReference querySnapshot = await _firestore.collection('perfil');

    await querySnapshot.get().then<dynamic>((QuerySnapshot snapshot) async {
      listaContato = snapshot.docs
          .map((document) => Contact.fromJson(document.data()))
          .toList();

      listaContato.forEach((contato) {
        print("${contato.famNameProf}, ${contato.nameProf}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: AppBar(
            centerTitle: true,
            title: Text(
              'Perfil',
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
        body: Column(children: <Widget>[
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(10),
              children: <Widget>[
                Column(
                  children: [
                    Container(
                      child: ReusableCard(
                        cor: Color(0xff15EBC4),
                      ),
                      // ),
                      margin: EdgeInsets.all(30.0),
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
                      width: 80.0,
                      height: 80.0,
                    ),
                  ],
                ),
                Rounded_InputField(
                  hintText: "Nome",
                  onChanged: (value) {},
                ),
                Rounded_InputField(
                  hintText: "Sobrenome",
                  onChanged: (value) {},
                ),
                Rounded_InputField(
                  hintText: "Nascimento",
                  onChanged: (value) {},
                ),
                Rounded_InputField(
                  hintText: "RG",
                  onChanged: (value) {},
                ),
                Rounded_InputField(
                  hintText: "Nome da Mãe",
                  onChanged: (value) {},
                ),
                Rounded_InputField(
                  hintText: "Grau de Proximidade",
                  onChanged: (value) {},
                ),
                Rounded_InputField(
                  hintText: "Sexo",
                  onChanged: (value) {},
                ),
                Rounded_InputField(
                  hintText: "Altura",
                  onChanged: (value) {},
                ),
                Rounded_InputField(
                  hintText: "Peso",
                  onChanged: (value) {},
                ),
                Rounded_InputField(
                  hintText: "Doenças Preexistentes",
                  onChanged: (value) {},
                ),
                Rounded_InputField(
                  hintText: "Remédios de uso Contínuo",
                  onChanged: (value) {},
                ),
                Rounded_InputField(
                  hintText: "Possui Alergia a algum medicamento?",
                  onChanged: (value) {},
                ),
                Rounded_InputField(
                  hintText: "Qual medicamento?",
                  onChanged: (value) {},
                ),
                Rounded_InputField(
                  hintText: "Tipo Sanguíneo",
                  onChanged: (value) {},
                ),
                Rounded_InputField(
                  hintText: "Possui Plano de Saúde?",
                  onChanged: (value) {},
                ),
                Rounded_InputField(
                  hintText: "Número da Carteirinha",
                  onChanged: (value) {},
                ),
                RoundedButton(
                  text: "Editar",
                  press: () {
                    getData();
                  },
                )
              ],
            ),
          )
        ]));
  }
}

class ReusableCard extends StatelessWidget {
  ReusableCard({@required this.cor, this.cardChild});

  final Color cor;
  final Widget cardChild;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(Icons.add_a_photo, color: Color(0xffC7F0E9), size: 44.0),
    );
  }
}

class Rounded_InputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const Rounded_InputField({
    Key key,
    this.hintText,
    this.icon,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField_Container(
      child: TextField(
        readOnly: true,
        style: TextStyle(color: Colors.black54, fontFamily: 'Monda'),
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class TextField_Container extends StatelessWidget {
  final Widget child;
  const TextField_Container({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}
