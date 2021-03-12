import 'package:flutter/material.dart';
import 'rounded_input_field.dart';
import 'rounded_button.dart';
import 'text_field_container.dart';
import 'constants.dart';
import 'package:flutter/services.dart';
import 'perfil_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'perfil_screen.dart';

class TelaAddPerfil extends StatelessWidget {
  final Widget child;
  TelaAddPerfil({
    Key key,
    this.child,
  }) : super(key: key);
  final _firestore = FirebaseFirestore.instance;

  String name_prof,
      fam_name_prof,
      birth_prof,
      rg_prof,
      mom_name_prof,
      prox_prof,
      sex_prof,
      dise_prof,
      medicine_prof,
      allergy_prof,
      d_allergy_prof,
      blood_prof,
      health_prof,
      n_health_prof,
      id_user,
      height_prof,
      weight_prof;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          centerTitle: true,
          title: Text(
            'Criar Perfil',
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
                RoundedInputField(
                  hintText: "Nome",
                  onChanged: (value) {
                    name_prof = value;
                  },
                ),
                RoundedInputField(
                  hintText: "Sobrenome",
                  onChanged: (value) {
                    fam_name_prof = value;
                  },
                ),
                RoundedInputField(
                  hintText: "Nascimento",
                  onChanged: (value) {
                    birth_prof = value;
                  },
                ),
                RoundedInputField(
                  hintText: "RG",
                  onChanged: (value) {
                    rg_prof = value;
                  },
                ),
                RoundedInputField(
                  hintText: "Nome da Mãe",
                  onChanged: (value) {
                    mom_name_prof = value;
                  },
                ),
                RoundedInputField(
                  hintText: "Grau de Proximidade",
                  onChanged: (value) {
                    prox_prof = value;
                  },
                ),
                RoundedInputField(
                  hintText: "Sexo",
                  onChanged: (value) {
                    sex_prof = value;
                  },
                ),
                TextFieldContainer(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    style:
                        TextStyle(color: Colors.black54, fontFamily: 'Monda'),
                    onChanged: (value) {
                      height_prof = value;
                    },
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                      // icon: Icon(
                      //   icon,
                      //   color: kPrimaryColor,
                      // ),
                      hintText: 'Altura',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                TextFieldContainer(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    style:
                        TextStyle(color: Colors.black54, fontFamily: 'Monda'),
                    onChanged: (value) {
                      weight_prof = value;
                    },
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                      icon: Image.asset(
                        'images/icons/weight.png',
                        color: kPrimaryColor,
                      ),
                      hintText: 'Peso',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                RoundedInputField(
                  hintText: "Doenças Preexistentes",
                  onChanged: (value) {
                    dise_prof = value;
                  },
                ),
                RoundedInputField(
                  hintText: "Remédios de uso Contínuo",
                  onChanged: (value) {
                    medicine_prof = value;
                  },
                ),
                RoundedInputField(
                  hintText: "Possui Alergia a algum medicamento?",
                  onChanged: (value) {
                    allergy_prof = value;
                  },
                ),
                RoundedInputField(
                  hintText: "Qual medicamento?",
                  onChanged: (value) {
                    d_allergy_prof = value;
                  },
                ),
                RoundedInputField(
                  hintText: "Tipo Sanguíneo",
                  onChanged: (value) {
                    blood_prof = value;
                  },
                ),
                RoundedInputField(
                  hintText: "Possui Plano de Saúde?",
                  onChanged: (value) {
                    health_prof = value;
                  },
                ),
                RoundedInputField(
                  hintText: "Número da Carteirinha",
                  onChanged: (value) {
                    n_health_prof = value;
                  },
                ),
                RoundedButton(
                  text: "Criar",
                  press: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return PerfilScreen();
                    }));

                    _firestore.collection('perfil').add(
                      {
                        'name_prof,': name_prof,
                        'fam_name_prof': fam_name_prof,
                        'birth_prof': birth_prof,
                        'rg_prof': rg_prof,
                        'mom_name_prof': mom_name_prof,
                        'prox_prof': prox_prof,
                        'sex_prof': sex_prof,
                        'dise_prof': dise_prof,
                        'medicine_prof': medicine_prof,
                        'allergy_prof': allergy_prof,
                        'd_allergy_prof': d_allergy_prof,
                        'blood_prof': blood_prof,
                        'health_prof': health_prof,
                        'n_health_prof': n_health_prof,
                        'id_user': id_user,
                        'height_prof': height_prof,
                        'weight_prof': weight_prof,
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),

      // Column(
      //   children: [
      //     Container(
      //       width: double.infinity,
      //       // Here i can use size.width but use double.infinity because both work as a same
      //       child: Stack(
      //         alignment: Alignment.center,
      //         children: <Widget>[
      //           child,
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
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
      child: Icon(Icons.add_a_photo, color: Color(0xffC7F0E9), size: 44.0),
      // margin: EdgeInsets.all(15.0),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(5.0),
      //   color: cor,
      // ),
    );
  }
}
