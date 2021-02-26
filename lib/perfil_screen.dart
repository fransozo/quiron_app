import 'package:flutter/material.dart';
import 'body_ficha_perfil.dart';

class PerfilScreen extends StatelessWidget {
  @override
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
        child: Container(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return BodyFicha();
                }),
              );
            },
            child: ReusableCard(
              cor: Color(0xff15EBC4),
            ),
          ),
          margin: EdgeInsets.all(50.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
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

//  Row(
//               children: [
//                 Expanded(
//                   child: GestureDetector(
//                     onTap: () {
//                       // setState(() {
//                       //   updateCardCor(1);
//                       // });
//                     },
//                     // child: ReusableCard(
//                     //   cor: Color(0xff15EBC4),
//                     //   cardChild:
//                     // ),
//                   ),
//                 ),
//                 Expanded(
//                   child: GestureDetector(
//                     onTap: () {
//                       // setState(() {
//                       //   updateCardCor(2);
//                       // });
//                     },
//                     child: ReusableCard(
//                       cor: Color(0xff15EBC4),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
