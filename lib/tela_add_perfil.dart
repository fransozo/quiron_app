import 'package:flutter/material.dart';
import 'rounded_input_field.dart';
import 'rounded_button.dart';
import 'text_field_container.dart';
import 'constants.dart';
import 'package:flutter/services.dart';
import 'perfil_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'drop_down_list.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class TelaAddPerfil extends StatefulWidget {
  final Widget child;
  final String doencaspreex;

  TelaAddPerfil({Key key, this.child, this.doencaspreex}) : super(key: key);

  @override
  _TelaAddPerfilState createState() => _TelaAddPerfilState();
}

class _TelaAddPerfilState extends State<TelaAddPerfil> {
  List<dynamic> initialvalue;
  List<dynamic> initialvalueRemCont;
  List<dynamic> initialvalueRemAlerg;

  InputBorder numPlanSau = InputBorder.none;
  InputBorder nameNull = InputBorder.none;
  InputBorder famNull = InputBorder.none;
  InputBorder nascNull = InputBorder.none;
  InputBorder rgNull = InputBorder.none;
  InputBorder momNull = InputBorder.none;
  Decoration borderDoencaNull = BoxDecoration(
      color: kPrimaryLightColor, borderRadius: BorderRadius.circular(29));
  Decoration borderRemAlergNull = BoxDecoration(
      color: kPrimaryLightColor, borderRadius: BorderRadius.circular(29));
  Decoration borderRemContNull = BoxDecoration(
      color: kPrimaryLightColor, borderRadius: BorderRadius.circular(29));

  Color sexoNull;
  Color doencasNull;
  Color remContNull;
  Color alergRemNull;
  Color planSauNull;
  Color doencasPreexNull;
  Color remedContNull;

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

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();
  final TextEditingController _controller5 = TextEditingController();
  final TextEditingController _controller6 = TextEditingController();
  final TextEditingController _controller7 = TextEditingController();
  final TextEditingController _controller8 = TextEditingController();
  final TextEditingController _controller9 = TextEditingController();
  final TextEditingController _controller10 = TextEditingController();

  void dispose() {
    _controller.dispose();
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    _controller5.dispose();
    _controller6.dispose();
    _controller7.dispose();
    _controller8.dispose();
    _controller9.dispose();
    _controller10.dispose();
    super.dispose();
  }

  void getCurrentUserEmail() async {
    User emailUser = _auth.currentUser;
    email = emailUser.email;
    print("$email");
  }

  Future<String> documentId() async {
    getCurrentUserEmail();
    QuerySnapshot resultado = await _firestore
        .collection("usuarios")
        .where("emailUser", isEqualTo: "$email")
        .get();
    resultado.docs.forEach((d) {
      qtdPerfis = d.get('qtd_perfil');
      print("Print da função $qtdPerfis & $idDoc");
    });

    return qtdPerfis;
  }

  getDocId() async {
    getCurrentUserEmail();
    QuerySnapshot resultado = await _firestore
        .collection("usuarios")
        .where("emailUser", isEqualTo: "$email")
        .get();
    resultado.docs.forEach((d) {
      idDoc = d.id;
      print(d.id);
    });
    return idDoc;
  }

  void addPerfil() {
    _firestore.collection('perfil').add(
      {
        //Envio Banco de dados
        'name_prof': name_prof, //Nome
        'fam_name_prof': fam_name_prof, //Sobrenome
        'birth_prof': birth_prof, //Data de Nascimento
        'rg_prof': rg_prof, //RG
        'mom_name_prof': mom_name_prof, //Nome da Mãe
        'sex_prof': _selectedSexo.sexo, //Sexo
        'dise_prof': doencasSelecionadas, //Doencas Preexistentes
        'medicine_prof': remedContSelecionados, //Remédios de Uso Contínuo
        'allergy_prof':
            alergRemedSelecionados, // Possui Alergia a algum Remédio (Sim ou Não)
        //'d_allergy_prof': alergRemedSelecionados, //Nome dos Remédios Alérgicos
        'blood_prof': _selectedSang.tipoSang, //Tipo Sanguíneo
        'health_prof':
            _selectedPlanSau.planSau, //Possui Plano de Saúde (Sim ou Não)
        'n_health_prof': n_health_prof, //Numero da Carteirinha
        'height_prof': height_prof, // Altura
        'weight_prof': weight_prof,
        'id_user': email,
      },
    );
  }

//Alerta de numero maximo de perfis excedido.
  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PerfilScreen();
        }));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alerta"),
      content: Text(
          "Número máximo de perfis atingido. Caso seja necessário exclua um perfil."),
      actions: [
        okButton,
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

  //Alerta de Formulário Null.
  showAlertForm(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Campos Obrigatórios"),
      content: Text("Favor preencher os campos destacados em vermelho"),
      actions: [
        okButton,
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

  final _items = _doenca
      .map((doenca) => MultiSelectItem<Doenca>(doenca, doenca.name))
      .toList();

  static List<Doenca> _doenca = [
    Doenca(id: 1, name: "Hipertensão"),
    Doenca(id: 2, name: "Diabetes"),
    Doenca(id: 3, name: "Asma"),
    Doenca(id: 4, name: "Câncer"),
    Doenca(id: 5, name: "Artrite"),
    Doenca(id: 6, name: "Colesterol Alto"),
    Doenca(id: 7, name: "Obesidade"),
    Doenca(id: 8, name: "Depressão"),
    Doenca(id: 9, name: "AVC"),
    Doenca(id: 10, name: "Insuficiência Renal"),
  ];

  final _itemsRemedios = _remedio
      .map((remedio) => MultiSelectItem<Remedio>(remedio, remedio.name))
      .toList();

  static List<Remedio> _remedio = [
    Remedio(id: 1, name: "Losartana"),
    Remedio(id: 2, name: "Glifage"),
    Remedio(id: 3, name: "Fenofibrato"),
    Remedio(id: 4, name: "Rivotril"),
    Remedio(id: 5, name: "Metformina"),
    Remedio(id: 6, name: "Symbicort"),
    Remedio(id: 7, name: "Loratadina"),
    Remedio(id: 8, name: "Diazepam"),
    Remedio(id: 9, name: "Sinvastatina"),
    Remedio(id: 10, name: "Hidroclorotiazida"),
  ];

  final _itemsAlergRemed = _alergRemedio
      .map((alergRemedio) =>
          MultiSelectItem<AlergRemed>(alergRemedio, alergRemedio.name))
      .toList();

  static List<AlergRemed> _alergRemedio = [
    AlergRemed(id: 1, name: "Losartana"),
    AlergRemed(id: 2, name: "Glifage"),
    AlergRemed(id: 3, name: "Fenofibrato"),
    AlergRemed(id: 4, name: "Rivotril"),
    AlergRemed(id: 5, name: "Metformina"),
    AlergRemed(id: 6, name: "Symbicort"),
    AlergRemed(id: 7, name: "Loratadina"),
    AlergRemed(id: 8, name: "Diazepam"),
    AlergRemed(id: 9, name: "Sinvastatina"),
    AlergRemed(id: 10, name: "Hidroclorotiazida"),
  ];

  //Lista Sexo
  List<Sexo> _sexo = Sexo.getSexo();
  List<DropdownMenuItem<Sexo>> _dropdownMenuItems;
  Sexo _selectedSexo;

  //Lista Plano de Saúde
  List<PlanSau> _saude = PlanSau.getPlanSau();
  List<DropdownMenuItem<PlanSau>> _dropdownMenuPlanSau;
  PlanSau _selectedPlanSau;

  //Lista Doenças Preexistes
  List<DoencaPreex> _doencas = DoencaPreex.getDoencaPreex();
  List<DropdownMenuItem<DoencaPreex>> _dropdownMenuDoencasPreex;
  DoencaPreex _selectedDoencasPreex;

  //Lista Nome das Doenças Preexistentes
  static List<String> doencasList = [];

  //Lista Remedios de Uso Contínuo
  List<RemedCont> _remedCont = RemedCont.getRemedCont();
  List<DropdownMenuItem<RemedCont>> _dropdownMenuRemedCont;
  RemedCont _selectedRemedCont;

  //Lista o Nome dos Remédios de Uso Contínuo
  static List<String> remContList = [];

  //Lista Alergia Remedios
  List<AlergiaRemed> _alergRem = AlergiaRemed.getAlergiaRemed();
  List<DropdownMenuItem<AlergiaRemed>> _dropdownMenuAlergRem;
  AlergiaRemed _selectedAlergRem;

  //Lista Nome dos Remedios que tem Alergia
  static List<String> alergRemList = [];

  //Lista Sangue
  List<TipoSang> _sangue = TipoSang.getTipoSang();
  List<DropdownMenuItem<TipoSang>> _dropdownMenuSangue;
  TipoSang _selectedSang;

  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_sexo);
    _selectedSexo = _dropdownMenuItems[0].value;
    _dropdownMenuSangue = buildDropdownMenuSangue(_sangue);
    _selectedSang = _dropdownMenuSangue[0].value;
    _dropdownMenuPlanSau = buildDropdownMenuPlanSau(_saude);
    _selectedPlanSau = _dropdownMenuPlanSau[0].value;
    _dropdownMenuAlergRem = buildDropdownMenuAlergRem(_alergRem);
    _selectedAlergRem = _dropdownMenuAlergRem[0].value;
    _dropdownMenuDoencasPreex = buildDropdownMenuDoencaPreex(_doencas);
    _selectedDoencasPreex = _dropdownMenuDoencasPreex[0].value;
    _dropdownMenuRemedCont = buildDropdownMenuRemedCont(_remedCont);
    _selectedRemedCont = _dropdownMenuRemedCont[0].value;
    super.initState();
  }

  //Cria Lista com as opções de Sexo
  List<DropdownMenuItem<Sexo>> buildDropdownMenuItems(List sexos) {
    List<DropdownMenuItem<Sexo>> items = [];
    for (Sexo sexo in sexos) {
      items.add(
        DropdownMenuItem(
          value: sexo,
          child: Text(sexo.sexo),
        ),
      );
    }
    return items;
  }

//Cria Lista com as opções de Sangue
  List<DropdownMenuItem<TipoSang>> buildDropdownMenuSangue(List sangue) {
    List<DropdownMenuItem<TipoSang>> items = [];
    for (TipoSang sang in sangue) {
      items.add(
        DropdownMenuItem(
          value: sang,
          child: Text(sang.tipoSang),
        ),
      );
    }
    return items;
  }

  //Cria Lista com as opções de Plano de Saúde
  List<DropdownMenuItem<PlanSau>> buildDropdownMenuPlanSau(List planSaude) {
    List<DropdownMenuItem<PlanSau>> items = [];
    for (PlanSau saude in planSaude) {
      items.add(
        DropdownMenuItem(
          value: saude,
          child: Text(saude.planSau),
        ),
      );
    }
    return items;
  }

  //Cria Lista com as opções de Doencas Preexistentes
  List<DropdownMenuItem<DoencaPreex>> buildDropdownMenuDoencaPreex(
      List doencapre) {
    List<DropdownMenuItem<DoencaPreex>> items = [];
    for (DoencaPreex doencas in doencapre) {
      items.add(
        DropdownMenuItem(
          value: doencas,
          child: Text(doencas.doencapreex),
        ),
      );
    }
    return items;
  }

  //Cria Lista com as opções de Alergia a remedios
  List<DropdownMenuItem<AlergiaRemed>> buildDropdownMenuAlergRem(
      List alergiaRem) {
    List<DropdownMenuItem<AlergiaRemed>> items = [];
    for (AlergiaRemed remedios in alergiaRem) {
      items.add(
        DropdownMenuItem(
          value: remedios,
          child: Text(remedios.alergRem),
        ),
      );
    }
    return items;
  }

  List<DropdownMenuItem<RemedCont>> buildDropdownMenuRemedCont(List remedCont) {
    List<DropdownMenuItem<RemedCont>> items = [];
    for (RemedCont remedio in remedCont) {
      items.add(
        DropdownMenuItem(
          value: remedio,
          child: Text(remedio.remedCont),
        ),
      );
    }
    return items;
  }

  onChangeDropdownSexo(Sexo selectedSexo) {
    setState(() {
      _selectedSexo = selectedSexo;
    });
  }

  onChangeDropdownDoenca(DoencaPreex selectedDoencas) {
    setState(() {
      _selectedDoencasPreex = selectedDoencas;
    });
  }

  onChangeDropdownSangue(TipoSang selectedSangue) {
    setState(() {
      _selectedSang = selectedSangue;
    });
  }

  onChangeDropdownPlanSaude(PlanSau selectedSaude) {
    setState(() {
      _selectedPlanSau = selectedSaude;
    });
  }

  onChangeDropdownAlergRem(AlergiaRemed selectedAlergRem) {
    setState(() {
      _selectedAlergRem = selectedAlergRem;
    });
  }

  onChangeDropdownRemedCont(RemedCont selectedRemedCont) {
    setState(() {
      _selectedRemedCont = selectedRemedCont;
    });
  }

  bool enableCampoDoencas() {
    bool enable;
    if (_selectedDoencasPreex.doencapreex == "Sim") {
      enable = true;
    } else
      enable = false;
    return enable;
  }

  bool enableCampoRemAlerg() {
    bool enable;
    if (_selectedAlergRem.alergRem == "Sim") {
      enable = true;
    } else
      enable = false;
    return enable;
  }

  bool enableCampoCart() {
    bool enable;
    if (_selectedPlanSau.planSau == "Sim") {
      enable = true;
    } else
      enable = false;
    return enable;
  }

  enableCampoRemCont() {
    bool enable;
    if (_selectedRemedCont.remedCont == "Sim") {
      enable = true;
    } else
      enable = false;
    return enable;
  }

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

//              ***************** Formulário ******************
//Nome
                RoundedInputField(
                  border: nameNull,
                  controller: _controller,
                  hintText: "Nome",
                  icon: Icon(Icons.person, color: kPrimaryColor),
                  onChanged: (value) {
                    name_prof = value;
                  },
                ),
//Sobrenome
                RoundedInputField(
                  border: famNull,
                  controller: _controller1,
                  hintText: "Sobrenome",
                  icon: Icon(Icons.person, color: kPrimaryColor),
                  onChanged: (value) {
                    fam_name_prof = value;
                  },
                ),
// Data de Nascimento
                RoundedInputField(
                  border: nascNull,
                  controller: _controller2,
                  keyboardtype: TextInputType.datetime,
                  icon: Icon(Icons.cake, color: kPrimaryColor),
                  maxlength: 10,
                  hintText: "Nascimento",
                  onChanged: (value) {
                    birth_prof = value;
                  },
                ),
//RG
                RoundedInputField(
                  border: rgNull,
                  controller: _controller3,
                  icon: Icon(Icons.badge, color: kPrimaryColor),
                  hintText: "RG",
                  onChanged: (value) {
                    rg_prof = value;
                  },
                ),
// Nome da Mãe
                RoundedInputField(
                  border: momNull,
                  controller: _controller4,
                  hintText: "Nome da Mãe",
                  icon: Image.asset(
                    'images/icons/woman.png',
                    color: kPrimaryColor,
                  ),
                  onChanged: (value) {
                    mom_name_prof = value;
                  },
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
                        value: _selectedSexo,
                        items: _dropdownMenuItems,
                        onChanged: onChangeDropdownSexo,
                        underline: Container(
                          color: sexoNull,
                          height: 2,
                        ),
                        style: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'Monda',
                            fontSize: 16.0),
                      ),
                    ]),
                  ),
                ),
//Altura
                TextFieldContainer(
                  decoration: BoxDecoration(
                    color: kPrimaryLightColor,
                    borderRadius: BorderRadius.circular(29),
                  ),
                  child: TextField(
                    controller: _controller5,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    style: TextStyle(
                      color: Colors.black54,
                      fontFamily: 'Monda',
                    ),
                    onChanged: (value) {
                      height_prof = value;
                    },
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.height,
                        color: kPrimaryColor,
                      ),
                      hintText: 'Altura',
                      border: InputBorder.none,
                    ),
                  ),
                ),
//Peso
                TextFieldContainer(
                  decoration: BoxDecoration(
                    color: kPrimaryLightColor,
                    borderRadius: BorderRadius.circular(29),
                  ),
                  child: TextField(
                    controller: _controller6,
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

//Doencas Preexistentes (Sim ou Não)
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
                          'images/icons/virus.png',
                          color: kPrimaryColor,
                        ),
                      ),
                      DropdownButton(
                        value: _selectedDoencasPreex,
                        items: _dropdownMenuDoencasPreex,
                        onChanged: onChangeDropdownDoenca,
                        underline: Container(
                          color: doencasPreexNull,
                          height: 2,
                        ),
                        style: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'Monda',
                            fontSize: 16.0),
                      ),
                    ]),
                  ),
                ),
//Opções das Doenças
                Visibility(
                    visible: enableCampoDoencas(),
                    child: TextFieldContainer(
                      decoration: borderDoencaNull,
                      child: Container(
                        child: Wrap(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      2.0, 8.0, 4.0, 8.0),
                                  child: Image.asset(
                                    'images/icons/virus.png',
                                    color: kPrimaryColor,
                                  ),
                                ),
                                SizedBox(
                                  width: 260,
                                  child: MultiSelectChipField(
                                    height: 200,
                                    scroll: false,
                                    decoration: BoxDecoration(
                                      color: kPrimaryLightColor,
                                    ),
                                    showHeader: false,
                                    items: _items,
                                    initialValue: initialvalue,
                                    selectedChipColor:
                                        kPrimaryColor.withOpacity(0.5),
                                    selectedTextStyle:
                                        TextStyle(color: Colors.black),
                                    onTap: (values) {
                                      doencasSelecionadas = values
                                          .toString()
                                          .replaceAll(RegExp(r'\['), '')
                                          .replaceAll(RegExp(r']'), '');

                                      print(doencasSelecionadas);
                                      setState(() {
                                        initialvalue = values;
                                      });

                                      //_selectedAnimals4 = values;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )),

//Remedios de Uso Contínuo (SIM ou NÃO)
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
                          'images/icons/medication.png',
                          color: kPrimaryColor,
                        ),
                      ),
                      DropdownButton(
                        value: _selectedRemedCont,
                        items: _dropdownMenuRemedCont,
                        onChanged: onChangeDropdownRemedCont,
                        underline: Container(
                          color: remContNull,
                          height: 2,
                        ),
                        style: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'Monda',
                            fontSize: 16.0),
                      ),
                    ]),
                  ),
                ),

//Nome do medicamento contínuo.
                Visibility(
                    visible: enableCampoRemCont(),
                    child: TextFieldContainer(
                      decoration: borderRemContNull,
                      child: Container(
                        child: Wrap(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      2.0, 8.0, 4.0, 8.0),
                                  child: Image.asset(
                                    'images/icons/virus.png',
                                    color: kPrimaryColor,
                                  ),
                                ),
                                SizedBox(
                                  width: 265,
                                  child: MultiSelectChipField(
                                    height: 200,
                                    scroll: false,
                                    decoration: BoxDecoration(
                                      color: kPrimaryLightColor,
                                    ),
                                    showHeader: false,
                                    items: _itemsRemedios,
                                    initialValue: initialvalueRemCont,
                                    selectedChipColor:
                                        kPrimaryColor.withOpacity(0.5),
                                    selectedTextStyle:
                                        TextStyle(color: Colors.black),
                                    onTap: (values) {
                                      remedContSelecionados = values
                                          .toString()
                                          .replaceAll(RegExp(r'\['), '')
                                          .replaceAll(RegExp(r']'), '');
                                      print(remedContSelecionados);
                                      setState(() {
                                        initialvalueRemCont = values;
                                      });

                                      //_selectedAnimals4 = values;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )),

//Possui Alergia a algum medicamento? (SIM ou NÃO)
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
                          'images/icons/medication.png',
                          color: kPrimaryColor,
                        ),
                      ),
                      DropdownButton(
                        value: _selectedAlergRem,
                        items: _dropdownMenuAlergRem,
                        onChanged: onChangeDropdownAlergRem,
                        underline: Container(
                          color: alergRemNull,
                          height: 2,
                        ),
                        style: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'Monda',
                            fontSize: 16.0),
                      ),
                    ]),
                  ),
                ),

//Nome do medicamento que é alérgico.
                Visibility(
                    visible: enableCampoRemAlerg(),
                    child: TextFieldContainer(
                      decoration: borderRemAlergNull,
                      child: Container(
                        child: Wrap(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      2.0, 8.0, 4.0, 8.0),
                                  child: Image.asset(
                                    'images/icons/virus.png',
                                    color: kPrimaryColor,
                                  ),
                                ),
                                SizedBox(
                                  width: 265,
                                  child: MultiSelectChipField(
                                    height: 200,
                                    scroll: false,
                                    decoration: BoxDecoration(
                                      color: kPrimaryLightColor,
                                    ),
                                    showHeader: false,
                                    items: _itemsAlergRemed,
                                    initialValue: initialvalueRemAlerg,
                                    selectedChipColor:
                                        kPrimaryColor.withOpacity(0.5),
                                    selectedTextStyle:
                                        TextStyle(color: Colors.black),
                                    onTap: (values) {
                                      alergRemedSelecionados = values
                                          .toString()
                                          .replaceAll(RegExp(r'\['), '')
                                          .replaceAll(RegExp(r']'), '');
                                      print(alergRemedSelecionados);
                                      setState(() {
                                        initialvalueRemAlerg = values;
                                      });

                                      //_selectedAnimals4 = values;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )),
//Tipo Sanguíneo
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
                          'images/icons/bloodtype.png',
                          color: kPrimaryColor,
                        ),
                      ),
                      DropdownButton(
                        value: _selectedSang,
                        items: _dropdownMenuSangue,
                        onChanged: onChangeDropdownSangue,
                        underline: Container(
                          height: 0,
                        ),
                        style: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'Monda',
                            fontSize: 16.0),
                      ),
                    ]),
                  ),
                ),
//Plano de Saude
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
                          'images/icons/health.png',
                          color: kPrimaryColor,
                        ),
                      ),
                      DropdownButton(
                        value: _selectedPlanSau,
                        items: _dropdownMenuPlanSau,
                        onChanged: onChangeDropdownPlanSaude,
                        underline: Container(
                          height: 0,
                        ),
                        style: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'Monda',
                            fontSize: 16.0),
                      ),
                    ]),
                  ),
                ),
//Carteirinha do Plano
                RoundedInputField(
                  controller: _controller8,
                  icon: Icon(Icons.credit_card, color: kPrimaryColor),
                  hintText: "Número da Carteirinha",
                  enable: enableCampoCart(),
                  border: InputBorder.none,
                  onChanged: (value) {
                    n_health_prof = value;
                  },
                ),
//Botão para criar perfil
                RoundedButton(
                  text: "Criar",
                  press: () async {
                    documentId();
                    getDocId();
                    dynamic qtd = await documentId();

                    print("*****ID do Documento Criado $idDoc");
                    print("****Doenças $doencasSelecionadas");
                    print("****Remédio Alergia $alergRemedSelecionados");

//Altera Cor Nome NULL
                    if (name_prof == null) {
                      setState(() {
                        nameNull = OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(29.0)),
                            borderSide: BorderSide(color: Colors.red));
                      });
                    }
//Altera Cor Sobrenome NULL
                    if (fam_name_prof == null) {
                      famNull = OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(29.0)),
                          borderSide: BorderSide(color: Colors.red));
                    }
//Altera Cor Data de Nascimento NULL
                    if (birth_prof == null) {
                      nascNull = OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(29.0)),
                          borderSide: BorderSide(color: Colors.red));
                    }
//Altera Cor RG NULL
                    if (rg_prof == null) {
                      rgNull = OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(29.0)),
                          borderSide: BorderSide(color: Colors.red));
                    }
//Altera Cor Nome da Mãe NULL
                    if (mom_name_prof == null) {
                      momNull = OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(29.0)),
                          borderSide: BorderSide(color: Colors.red));
                    }
//Altera Cor Sexo NULL
                    if (_selectedSexo.sexo == "Sexo") {
                      sexoNull = Colors.red;
                    }
//Altera Cor Doenças Preexistentes (Sim ou Não) NULL
                    if (_selectedDoencasPreex.doencapreex ==
                        "Possui Doenças Preexistentes?") {
                      doencasPreexNull = Colors.red;
                    }
                    //Altera Cor Seleção Doenças Preexistentes NULL
                    if (doencasSelecionadas == "[]" ||
                        doencasSelecionadas == null) {
                      borderDoencaNull = BoxDecoration(
                        border: Border.all(width: 1.0, color: Colors.red),
                        color: kPrimaryLightColor,
                        borderRadius: BorderRadius.circular(29),
                      );
                    }
//Altera Cor Remédios de Uso Contínuo NULL
                    if (_selectedRemedCont.remedCont ==
                        "Remédio de Uso Contínuo") {
                      remContNull = Colors.red;
                    }
//Altera Cor Seleção Remédios de Uso Contínuo NULL
                    if (remedContSelecionados == "[]" ||
                        remedContSelecionados == null) {
                      borderRemContNull = BoxDecoration(
                        border: Border.all(width: 1.0, color: Colors.red),
                        color: kPrimaryLightColor,
                        borderRadius: BorderRadius.circular(29),
                      );
                    }
//Altera Cor Possui Alergia a Algum Remédio (Sim ou Não) NULL
                    if (_selectedAlergRem.alergRem ==
                        'Possui Alergia a Algum Remédio?') {
                      alergRemNull = Colors.red;
                    }
//Altera Cor Seleção Alergia Remédios NULL
                    if (alergRemedSelecionados == "[]" ||
                        alergRemedSelecionados == null) {
                      borderRemAlergNull = BoxDecoration(
                        border: Border.all(width: 1.0, color: Colors.red),
                        color: kPrimaryLightColor,
                        borderRadius: BorderRadius.circular(29),
                      );
                    }

//Altera Cor Plano de Saúde (Sim ou Não) NULL
                    if (_selectedPlanSau.planSau == "Possui Plano de Saúde?") {
                      planSauNull = Colors.red;
                    }

//Altera Cor Carteirinha NULL
                    if (n_health_prof == null) {
                      numPlanSau = OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(29.0)),
                          borderSide: BorderSide(color: Colors.red));
                    }

                    if (name_prof == null ||
                        fam_name_prof == null ||
                        birth_prof == null ||
                        rg_prof == null ||
                        mom_name_prof == null ||
                        _selectedSexo.sexo == "Sexo" ||
                        doencaspreex == "Possui Doenças Preexistentes?" ||
                        remCont == "Remédios de Uso Contínuo" ||
                        d_allergy_prof == 'Possui Alergia a Algum Remédio?' ||
                        _selectedAlergRem.alergRem == null) {
                      return showAlertForm(context);
                    }

                    if (qtd == '0') {
                      _firestore
                          .collection('usuarios')
                          .doc(idDoc)
                          .update({'qtd_perfil': '1'});
                      addPerfil();
                      print(qtd);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return PerfilScreen();
                      }));
                    } else if (qtd == '1') {
                      _firestore
                          .collection('usuarios')
                          .doc(idDoc)
                          .update({'qtd_perfil': '2'});
                      addPerfil();
                      print(qtd);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return PerfilScreen();
                      }));
                    } else if (qtd == '2') {
                      _firestore
                          .collection('usuarios')
                          .doc(idDoc)
                          .update({'qtd_perfil': '3'});
                      addPerfil();
                      print(qtd);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return PerfilScreen();
                      }));
                    } else if (qtd == '3') {
                      _firestore
                          .collection('usuarios')
                          .doc(idDoc)
                          .update({'qtd_perfil': '4'});
                      addPerfil();
                      print(qtd);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return PerfilScreen();
                      }));
                    } else {
                      showAlertDialog(context);
                    }
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

class Doenca {
  final int id;
  final String name;

  Doenca({
    this.id,
    this.name,
  });

  String toString() {
    return '$name';
  }
}

class Remedio {
  final int id;
  final String name;

  Remedio({
    this.id,
    this.name,
  });

  String toString() {
    return '$name';
  }
}

class AlergRemed {
  final int id;
  final String name;

  AlergRemed({
    this.id,
    this.name,
  });

  String toString() {
    return '$name';
  }
}
