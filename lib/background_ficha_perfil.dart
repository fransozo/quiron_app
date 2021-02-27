import 'package:flutter/material.dart';
import 'rounded_input_field.dart';
import 'rounded_button.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key key,
    @required this.child,
  }) : super(key: key);

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
          // Container(
          //   child:
          //       // GestureDetector(
          //       //   onTap: () {
          //       //     Navigator.push(
          //       //       context,
          //       //       MaterialPageRoute(builder: (context) {
          //       //         return BodyFicha();
          //       //       }),
          //       //     );
          //       //   },
          //       //   child:
          //       ReusableCard(
          //     cor: Color(0xff15EBC4),
          //   ),
          //   // ),
          //   margin: EdgeInsets.all(30.0),
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(10.0),
          //       boxShadow: [
          //         BoxShadow(
          //           color: Colors.grey[300],
          //           spreadRadius: 4,
          //           blurRadius: 10,
          //           offset: Offset(0, 3),
          //         )
          //       ],
          //       color: Color(0xFF15EBC4)),
          //   width: 80.0,
          //   height: 80.0,
          // ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(10),
              children: <Widget>[
                Column(
                  children: [
                    Container(
                      child:
                          // GestureDetector(
                          //   onTap: () {
                          //     Navigator.push(
                          //       context,
                          //       MaterialPageRoute(builder: (context) {
                          //         return BodyFicha();
                          //       }),
                          //     );
                          //   },
                          //   child:
                          ReusableCard(
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
                  onChanged: (value) {},
                ),
                RoundedInputField(
                  hintText: "Sobrenome",
                  onChanged: (value) {},
                ),
                RoundedInputField(
                  hintText: "Nascimento",
                  onChanged: (value) {},
                ),
                RoundedInputField(
                  hintText: "RG",
                  onChanged: (value) {},
                ),
                RoundedInputField(
                  hintText: "Nome da Mãe",
                  onChanged: (value) {},
                ),
                RoundedInputField(
                  hintText: "Grau de Proximidade",
                  onChanged: (value) {},
                ),
                RoundedInputField(
                  hintText: "Sexo",
                  onChanged: (value) {},
                ),
                RoundedInputField(
                  hintText: "Altura",
                  onChanged: (value) {},
                ),
                RoundedInputField(
                  hintText: "Peso",
                  onChanged: (value) {},
                ),
                RoundedInputField(
                  hintText: "Doenças Preexistentes",
                  onChanged: (value) {},
                ),
                RoundedInputField(
                  hintText: "Remédios de uso Contínuo",
                  onChanged: (value) {},
                ),
                RoundedInputField(
                  hintText: "Possui Alergia a algum medicamento?",
                  onChanged: (value) {},
                ),
                RoundedInputField(
                  hintText: "Qual medicamento?",
                  onChanged: (value) {},
                ),
                RoundedInputField(
                  hintText: "Tipo Sanguíneo",
                  onChanged: (value) {},
                ),
                RoundedInputField(
                  hintText: "Possui Plano de Saúde?",
                  onChanged: (value) {},
                ),
                RoundedInputField(
                  hintText: "Número da Carteirinha",
                  onChanged: (value) {},
                ),
                RoundedButton(
                  text: "Criar",
                  press: () {},
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
