import 'package:flutter/material.dart';
import 'body.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(90.0),
          child: AppBar(
            centerTitle: true,
            title: Text(
              'Login',
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
      ),
    );
  }
}
