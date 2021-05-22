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
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class QrCode extends StatelessWidget {
  QrCode({Key key, this.idPerfil}) : super(key: key);

  String idPerfil;

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: buildAppBar("QR CODE"),
        ),
        body: Center(
            child: Column(
          children: [
            Container(
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    boxShadow: [
                      new BoxShadow(
                        color: Colors.black,
                        blurRadius: 10.0,
                      ),
                    ],
                    color: kPrimaryLightColor,
                    borderRadius: BorderRadius.circular(29)),
                height: 50,
                width: 330,
                child: Center(
                  child: Text(
                    "Mostre este QRCode para a recepcionista do Hospital",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black54,
                        fontFamily: 'Monda',
                        fontSize: 16.0),
                  ),
                )),
            Container(
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.black,
                      blurRadius: 10.0,
                    ),
                  ],
                  color: kPrimaryLightColor,
                  borderRadius: BorderRadius.circular(29)),
              height: 300,
              child: SfBarcodeGenerator(
                value:
                    'https://firestore.googleapis.com/v1/projects/quiron-eb41f/databases/(default)/documents/consultas/$idPerfil',
                symbology: QRCode(),
                showValue: false,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 1, vertical: 5),
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
                      print(idPerfil);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return PerfilScreen();
                      }));
                    },
                    child: Text("Perfis",
                        style: TextStyle(fontSize: 30.0, color: Colors.white))),
              ),
            ),
          ],
        )));
  }
}
