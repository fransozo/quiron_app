import 'package:flutter/material.dart';
import 'rounded_input_field.dart';
import 'rounded_button.dart';
import 'constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'consulta.dart';

final _firestore = FirebaseFirestore.instance;

class TelaPerfil extends StatelessWidget {
  final Widget child;
  TelaPerfil({Key key, @required this.child, this.rgPerfil}) : super(key: key);

  String rgPerfil;

  void getDados() async {
    await for (var snapshot in _firestore.collection('perfil').snapshots()) {
      for (var dado in snapshot.docs) {
        print(dado.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    getDados();

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
                StreamBuilder<QuerySnapshot>(
                  stream: _firestore
                      .collection('perfil')
                      .where("rg_prof", isEqualTo: '$rgPerfil')
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
                    List<InputField> dadosWidgets = [];
                    for (var dado in dados) {
                      final dadoName = dado.get('name_prof');
                      final dadoFamName = dado.get('fam_name_prof');
                      final dadoAllergy = dado.get('allergy_prof');
                      final dadoBirth = dado.get('birth_prof');
                      final dadoDise = dado.get('dise_prof');
                      final dadoHealth = dado.get('health_prof');
                      final dadoHeight = dado.get('height_prof');
                      final dadoDAlergy = dado.get('d_allergy_prof');
                      final dadoMedici = dado.get('medicine_prof');
                      final dadoMom = dado.get('mom_name_prof');
                      final dadoNHealth = dado.get('n_health_prof');
                      final dadoProx = dado.get('prox_prof');
                      final dadoRG = dado.get('rg_prof');
                      final dadoSex = dado.get('sex_prof');
                      final dadoWeight = dado.get('weight_prof');
                      final dadoBlood = dado.get('blood_prof');

                      final dadosWidget = InputField(
                        textName: dadoName,
                        textFamName: dadoFamName,
                        textAllergy: dadoAllergy,
                        textBirth: dadoBirth,
                        textDise: dadoDise,
                        textHealth: dadoHealth,
                        textHeight: dadoHeight,
                        textDAlergy: dadoDAlergy,
                        textMedici: dadoMedici,
                        textMom: dadoMom,
                        textNHealth: dadoNHealth,
                        textProx: dadoProx,
                        textRG: dadoRG,
                        textSex: dadoSex,
                        textWeight: dadoWeight,
                        textBlood: dadoBlood,
                      );

                      dadosWidgets.add(dadosWidget);
                    }
                    return Column(
                      children: dadosWidgets,
                    );
                  },
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 1, vertical: 5),
                  width: size.width * 0.8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(29),
                    child: TextButton(
                        style: ButtonStyle(
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xFF15EBC4),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Consulta(rgPerfil: '$rgPerfil');
                          }));
                        },
                        child: Text("Consulta",
                            style: TextStyle(
                                fontSize: 30.0, color: Colors.white))),
                  ),
                ),
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

class InputField extends StatelessWidget {
  InputField({
    this.textName,
    this.textFamName,
    this.textAllergy,
    this.textBirth,
    this.textDise,
    this.textHealth,
    this.textHeight,
    this.textDAlergy,
    this.textMedici,
    this.textMom,
    this.textNHealth,
    this.textProx,
    this.textRG,
    this.textSex,
    this.textWeight,
    this.textBlood,
  });

  final String textName;
  final String textFamName;
  final String textAllergy;
  final String textBirth;
  final String textDise;
  final String textHealth;
  final String textHeight;
  final String textDAlergy;
  final String textMedici;
  final String textMom;
  final String textNHealth;
  final String textProx;
  final String textRG;
  final String textSex;
  final String textWeight;

  final String textBlood;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        RoundedInputField(
          hintText: '$textName $textFamName',
          onChanged: (value) {},
        ),
        RoundedInputField(
          hintText: textBirth,
          onChanged: (value) {},
        ),
        RoundedInputField(
          hintText: textRG,
          onChanged: (value) {},
        ),
        RoundedInputField(
          hintText: textMom,
          onChanged: (value) {},
        ),
        RoundedInputField(
          hintText: textProx,
          onChanged: (value) {},
        ),
        RoundedInputField(
          hintText: textSex,
          onChanged: (value) {},
        ),
        RoundedInputField(
          hintText: '$textHeight cm',
          onChanged: (value) {},
        ),
        RoundedInputField(
          hintText: '$textWeight Kg',
          onChanged: (value) {},
        ),
        RoundedInputField(
          hintText: textDise,
          onChanged: (value) {},
        ),
        RoundedInputField(
          hintText: textMedici,
          onChanged: (value) {},
        ),
        RoundedInputField(
          hintText: textAllergy,
          onChanged: (value) {},
        ),
        RoundedInputField(
          hintText: textDAlergy,
          onChanged: (value) {},
        ),
        RoundedInputField(
          hintText: textBlood,
          onChanged: (value) {},
        ),
        RoundedInputField(
          hintText: textHealth,
          onChanged: (value) {},
        ),
        RoundedInputField(
          hintText: textNHealth,
          onChanged: (value) {},
        ),
      ],
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
