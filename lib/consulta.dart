import 'package:Quiron/tela_add_perfil.dart';
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
import 'tela_login.dart';
import 'drop_down_list.dart';
import 'rounded_input_field.dart';

final _firestore = FirebaseFirestore.instance;

class Consulta extends StatefulWidget {
  final Widget child;
  Consulta({Key key, @required this.child, this.rgPerfil}) : super(key: key);

  String rgPerfil;

  @override
  _ConsultaState createState() => _ConsultaState();
}

class _ConsultaState extends State<Consulta> {
  String emailUser;

  String email;

  String name_prof;

  String fam_name_prof;

  String birth_prof;

  String rg_prof;

  String mom_name_prof;

  String sex_prof;

  String dise_prof;

  String medicine_prof;

  String allergy_prof;

  String d_allergy_prof;

  String blood_prof;

  String health_prof;

  String n_health_prof;

  String id_user;

  String height_prof;

  String qtdPerfis;

  String idDoc;

  String doencaspreex;

  String remCont;

  String weight_prof;

  String doencasSelecionadas;

  String remedContSelecionados;

  String alergRemedSelecionados;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          centerTitle: true,
          title: Text(
            'Consulta',
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
                StreamBuilder<QuerySnapshot>(
                  stream: _firestore
                      .collection('perfil')
                      .where("rg_prof", isEqualTo: '${widget.rgPerfil}')
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
                      final dadoMedici = dado.get('medicine_prof');
                      final dadoMom = dado.get('mom_name_prof');
                      final dadoNHealth = dado.get('n_health_prof');
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
                        textMedici: dadoMedici,
                        textMom: dadoMom,
                        textNHealth: dadoNHealth,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class InputField extends StatefulWidget {
  InputField(
      {this.textName,
      this.textFamName,
      this.textAllergy,
      this.textBirth,
      this.textDise,
      this.textHealth,
      this.textHeight,
      this.textMedici,
      this.textMom,
      this.textNHealth,
      this.textRG,
      this.textSex,
      this.textWeight,
      this.textBlood,
      this.selectedFebre,
      this.dropdownMenuFebre});

  final String textFamName;
  final String textAllergy;
  final String textBirth;
  final String textDise;
  final String textHealth;
  final String textHeight;
  final String textMedici;
  final String textMom;
  final String textNHealth;
  final Febre selectedFebre;
  final String textRG;
  final String textSex;
  final String textWeight;
  final List<DropdownMenuItem<Febre>> dropdownMenuFebre;
  final String textBlood;
  final String textName;

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  List<Febre> _febre = Febre.getFebre();
  List<DropdownMenuItem<Febre>> _dropdownMenuFebre;
  Febre _selectedFebre;

  String sintomas;
  String temperatura;

  List<DropdownMenuItem<Febre>> buildDropdownMenuFebre(List febres) {
    List<DropdownMenuItem<Febre>> items = [];
    for (Febre febre in febres) {
      items.add(
        DropdownMenuItem(
          value: febre,
          child: Text(febre.febre),
        ),
      );
    }
    return items;
  }

  void initState() {
    _dropdownMenuFebre = buildDropdownMenuFebre(_febre);

    _selectedFebre = _dropdownMenuFebre[0].value;
    super.initState();
  }

  onChangeDropdownFebre(Febre selectedFebre) {
    setState(() {
      _selectedFebre = selectedFebre;
    });
  }

  void addConsulta() {
    _firestore.collection('consultas').add(
      {
        //Envio Banco de dados
        'name_prof': widget.textName, //Nome
        'fam_name_prof': widget.textFamName, //Sobrenome
        'birth_prof': widget.textBirth, //Data de Nascimento
        'rg_prof': widget.textRG, //RG
        'mom_name_prof': widget.textMom, //Nome da Mãe
        'sex_prof': widget.textSex, //Sexo
        'dise_prof': widget.textDise, //Doencas Preexistentes
        'medicine_prof': widget.textMedici, //Remédios de Uso Contínuo
        'allergy_prof':
            widget.textAllergy, // Possui Alergia a algum Remédio (Sim ou Não)
        //'d_allergy_prof': alergRemedSelecionados, //Nome dos Remédios Alérgicos
        'blood_prof': widget.textBlood, //Tipo Sanguíneo
        'health_prof': widget.textHealth, //Possui Plano de Saúde (Sim ou Não)
        'n_health_prof': widget.textNHealth, //Numero da Carteirinha
        'height_prof': widget.textHeight, // Altura
        'weight_prof': widget.textWeight,
        'temperatura': temperatura,
        'sintomas': sintomas,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        RoundedField(
          labelText: "Nome ",
          hintText: '${widget.textName} ${widget.textFamName}',
          onChanged: (value) {},
        ),
//Sexo  (Masculino ou Feminino)
        TextFieldContainer(
          decoration: BoxDecoration(
            color: kPrimaryLightColor,
            borderRadius: BorderRadius.circular(29),
          ),
          child: Container(
            child: Row(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(2.0, 8.0, 14.0, 8.0),
                child: Image.asset(
                  'images/icons/sex.png',
                  color: kPrimaryColor,
                ),
              ),
              DropdownButton(
                value: _selectedFebre,
                items: _dropdownMenuFebre,
                onChanged: onChangeDropdownFebre,
                style: TextStyle(
                    color: Colors.black54, fontFamily: 'Monda', fontSize: 16.0),
              ),
            ]),
          ),
        ),
//Altura
        RoundedInputField(
          hintText: "Qual Temperatura?",
          onChanged: (value) {
            temperatura = value;
          },
        ),
        RoundedInputField(
          hintText: "Sintomas",
          onChanged: (value) {
            sintomas = value;
          },
        ),
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
                onPressed: () {
                  addConsulta();
                  print(widget.textName);
                  print(_selectedFebre.febre);
                  print(temperatura);
                  print(sintomas);
                },
                child: Text("Consulta",
                    style: TextStyle(fontSize: 30.0, color: Colors.white))),
          ),
        ),
      ],
    );
  }
}

// ignore: camel_case_types
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

class RoundedField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedField({
    Key key,
    this.hintText,
    this.icon,
    this.onChanged,
    this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: Column(
        children: [
          Text(labelText),
          Text(hintText),
        ],
      ),
    );
  }
}
