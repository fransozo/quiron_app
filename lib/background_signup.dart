import 'package:flutter/material.dart';

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
      body: Column(
        children: [
          Container(
            width: double.infinity,
            // Here i can use size.width but use double.infinity because both work as a same
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                child,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
