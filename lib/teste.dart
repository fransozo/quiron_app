import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Multi Select',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Multi Select'),
    );
  }
}

class Animal {
  final int id;
  final String name;

  Animal({
    this.id,
    this.name,
  });

  @override
  String toString() {
    return '$name';
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static List<Animal> _animals = [
    Animal(id: 1, name: "Hipertensão"),
    Animal(id: 2, name: "Diabetes"),
    Animal(id: 3, name: "Asma"),
    Animal(id: 4, name: "Câncer"),
    Animal(id: 5, name: "Artrite"),
    Animal(id: 6, name: "Insuficiência Renal"),
    Animal(id: 7, name: "Obesidade"),
    Animal(id: 8, name: "Depressão"),
    Animal(id: 9, name: "AVC"),
    Animal(id: 10, name: "Colesterol Alto"),
  ];
  final _items = _animals
      .map((animal) => MultiSelectItem<Animal>(animal, animal.name))
      .toList();
  List<Animal> _selectedAnimals = [];
  //List<Animal> _selectedAnimals2 = [];
  //List<Animal> _selectedAnimals3 = [];
  //List<Animal> _selectedAnimals4 = [];
  //List<Animal> _selectedAnimals5 = [];
  //final _multiSelectKey = GlobalKey<FormFieldState>();

  @override
  //void initState() {
  //  _selectedAnimals5 = _animals;
  //  super.initState();
  //}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              SizedBox(height: 40),
              //################################################################################################
              // Rounded blue MultiSelectDialogField
              //################################################################################################
              MultiSelectDialogField(
                items: _items,
                title: Text("Selecione as Doenças"),
                selectedColor: Colors.blue,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  border: Border.all(
                    color: Colors.blue,
                    width: 2,
                  ),
                ),
                buttonIcon: Icon(
                  Icons.pets,
                  color: Colors.blue,
                ),
                buttonText: Text(
                  "Possui Alguma Doença Preexistente?",
                  style: TextStyle(
                    color: Colors.blue[800],
                    fontSize: 16,
                  ),
                ),
                onConfirm: (results) {
                  _selectedAnimals = results;
                  print(_selectedAnimals.toString());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
