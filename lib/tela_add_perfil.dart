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
import 'doencas_lista.dart';

class TelaAddPerfil extends StatefulWidget {
  final Widget child;
  TelaAddPerfil({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  _TelaAddPerfilState createState() => _TelaAddPerfilState();
}

class _TelaAddPerfilState extends State<TelaAddPerfil> {
  String value = "";

  List<MultiSelectDialogItem<int>> multiItem = List();

  final valuestopopulate = {
    1: "Hipertensão",
    2: "Diabetes",
    3: "Asma",
    4: "Câncer",
    5: "Artrite",
    6: "Insuficiência Renal",
    7: "Obesidade",
    8: "Depressão",
    9: "AVC",
    10: "Colesterol Alto",
  };

  void populateMultiselect() {
    for (int v in valuestopopulate.keys) {
      multiItem.add(MultiSelectDialogItem(v, valuestopopulate[v]));
    }
  }

  void showMultiSelect(BuildContext context) async {
    multiItem = [];
    populateMultiselect();
    final items = multiItem;
    // final items = <MultiSelectDialogItem<int>>[
    //   MultiSelectDialogItem(1, 'India'),
    //   MultiSelectDialogItem(2, 'USA'),
    //   MultiSelectDialogItem(3, 'Canada'),
    // ];

    final selectedValues = await showDialog<Set<int>>(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          items: items,
          initialSelectedValues: [].toSet(),
        );
      },
    );

    print(selectedValues);
    getvaluefromkey(selectedValues);
  }

  void getvaluefromkey(Set selection) {
    if (selection != null) {
      for (int x in selection.toList()) {
        print(valuestopopulate[x]);
      }
    }
  }

  final _firestore = FirebaseFirestore.instance;

  final _auth = FirebaseAuth.instance;

  String emailUser;

  String email;

  void getCurrentUserEmail() async {
    User emailUser = _auth.currentUser;
    email = emailUser.email;
    print("$email");
  }

  String name_prof,
      fam_name_prof,
      birth_prof,
      rg_prof,
      mom_name_prof,
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
      qtdPerfis,
      idDoc,
      weight_prof;

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
        'name_prof': name_prof,
        'fam_name_prof': fam_name_prof,
        'birth_prof': birth_prof,
        'rg_prof': rg_prof,
        'mom_name_prof': mom_name_prof,
        'sex_prof': _selectedSexo.sexo,
        'dise_prof': dise_prof,
        'medicine_prof': medicine_prof,
        'd_allergy_prof': d_allergy_prof,
        'allergy_prof': _selectedAlergRem.alergRem,
        'blood_prof': _selectedSang.tipoSang,
        'health_prof': _selectedPlanSau.planSau,
        'n_health_prof': n_health_prof,
        'height_prof': height_prof,
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

  showDoencas() {}

  //Lista Sexo
  List<Sexo> _sexo = Sexo.getSexo();
  List<DropdownMenuItem<Sexo>> _dropdownMenuItems;
  Sexo _selectedSexo;

  //Lista Sangue
  List<TipoSang> _sangue = TipoSang.getTipoSang();
  List<DropdownMenuItem<TipoSang>> _dropdownMenuSangue;
  TipoSang _selectedSang;

  //Lista Plano de Saúde
  List<PlanSau> _saude = PlanSau.getPlanSau();
  List<DropdownMenuItem<PlanSau>> _dropdownMenuPlanSau;
  PlanSau _selectedPlanSau;

  //Lista Alergia Remedios
  List<AlergiaRemed> _alergRem = AlergiaRemed.getAlergiaRemed();
  List<DropdownMenuItem<AlergiaRemed>> _dropdownMenuAlergRem;
  AlergiaRemed _selectedAlergRem;

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

  onChangeDropdownSexo(Sexo selectedSexo) {
    setState(() {
      _selectedSexo = selectedSexo;
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

  bool enableCampoMed() {
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
                  icon: Icons.person,
                  onChanged: (value) {
                    name_prof = value;
                  },
                ),
                RoundedInputField(
                  hintText: "Sobrenome",
                  icon: Icons.person,
                  onChanged: (value) {
                    fam_name_prof = value;
                  },
                ),
                RoundedInputField(
                  keyboardtype: TextInputType.datetime,
                  icon: Icons.cake,
                  maxlength: 10,
                  hintText: "Nascimento",
                  onChanged: (value) {
                    birth_prof = value;
                  },
                ),
                RoundedInputField(
                  icon: Icons.badge,
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

                TextFieldContainer(
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

                TextFieldContainer(
                  child: TextField(
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
                TextFieldContainer(
                  child: Container(
                    child: Row(children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(2.0, 8.0, 14.0, 8.0),
                        child: Image.asset(
                          'images/icons/virus.png',
                          color: kPrimaryColor,
                        ),
                      ),
                      TextButton(
                          style: ButtonStyle(
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                              EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFFC7F0E9),
                            ),
                          ),
                          onPressed: () => showMultiSelect(context),
                          child: Text("Possui Doenças Preexistentes?",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black54,
                                fontFamily: 'Monda',
                              ))),
                    ]),
                  ),
                ),
                RoundedInputField(
                  hintText: "Remédios de uso Contínuo",
                  onChanged: (value) {
                    medicine_prof = value;
                  },
                ),
//Possui Alergia a algum medicamento?;
                TextFieldContainer(
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
//Nome do medicamento que é alérgico.
                RoundedInputField(
                  hintText: "Qual medicamento?",
                  enable: enableCampoMed(),
                  onChanged: (value) {
                    d_allergy_prof = value;
                  },
                ),
//Tipo Sanguíneo
                TextFieldContainer(
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
                  hintText: "Número da Carteirinha",
                  enable: enableCampoCart(),
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

                    print("Print botão criar $idDoc");

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

class MultiSelectDialogItem<V> {
  const MultiSelectDialogItem(this.value, this.label);

  final V value;
  final String label;
}

class MultiSelectDialog<V> extends StatefulWidget {
  MultiSelectDialog({Key key, this.items, this.initialSelectedValues})
      : super(key: key);

  final List<MultiSelectDialogItem<V>> items;
  final Set<V> initialSelectedValues;

  @override
  State<StatefulWidget> createState() => _MultiSelectDialogState<V>();
}

class _MultiSelectDialogState<V> extends State<MultiSelectDialog<V>> {
  final _selectedValues = Set<V>();

  void initState() {
    super.initState();
    if (widget.initialSelectedValues != null) {
      _selectedValues.addAll(widget.initialSelectedValues);
    }
  }

  void _onItemCheckedChange(V itemValue, bool checked) {
    setState(() {
      if (checked) {
        _selectedValues.add(itemValue);
      } else {
        _selectedValues.remove(itemValue);
      }
    });
  }

  void _onCancelTap() {
    Navigator.pop(context);
  }

  void _onSubmitTap() {
    Navigator.pop(context, _selectedValues);
    print(_selectedValues);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Selecione as Doenças'),
      contentPadding: EdgeInsets.only(top: 12.0),
      content: SingleChildScrollView(
        child: ListTileTheme(
          contentPadding: EdgeInsets.fromLTRB(14.0, 0.0, 24.0, 0.0),
          child: ListBody(
            children: widget.items.map(_buildItem).toList(),
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('CANCEL'),
          onPressed: _onCancelTap,
        ),
        FlatButton(
          child: Text('OK'),
          onPressed: _onSubmitTap,
        )
      ],
    );
  }

  Widget _buildItem(MultiSelectDialogItem<V> item) {
    final checked = _selectedValues.contains(item.value);
    return CheckboxListTile(
      value: checked,
      title: Text(item.label),
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (checked) => _onItemCheckedChange(item.value, checked),
    );
  }
}
