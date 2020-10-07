import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  void _resetfield() {
    pesoController.text = "";
    alturaController.text = "";
    setState(() {
      _infoText = "Informe Seus Dados";
    });
  }

  void _calcular() {
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text) / 100;
      double imc = peso / (altura * altura);
      if (imc < 18.6) {
        _infoText = "Abaixo do Peso ${imc.toStringAsPrecision(2)}";
      }
      if (imc >= 29.9) {
        _infoText = "Abaixo do Peso ${imc.toStringAsPrecision(2)}";
      } else {
        _infoText =
            "Peso Ideal, Nunca perca o Foco ${imc.toStringAsPrecision(2)}";
      }
    });
  }

  String _infoText = "Informe Seus Dados";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora Imc"),
          centerTitle: true,
          backgroundColor: Colors.deepPurpleAccent,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetfield,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(
                    Icons.person_outline,
                    size: 130.0,
                    color: Colors.white,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Peso  (KG)",
                        labelStyle: TextStyle(
                            color: Colors.deepPurple, fontSize: 25.0)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.deepPurple),
                    controller: pesoController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira seu Peso";
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Altura (cm)",
                        labelStyle: TextStyle(
                            color: Colors.deepPurple, fontSize: 25.0)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.deepPurple),
                    controller: alturaController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira sua Altura";
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Container(
                      height: 50.0,
                      child: RaisedButton(
                          onPressed: () {
                            if (_formkey.currentState.validate()) {
                              _calcular();
                            }
                          },
                          child: Text(
                            "Calcular",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w100,
                                fontSize: 25.0),
                          ),
                          color: Colors.deepPurple),
                    ),
                  ),
                  Text(
                    _infoText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w100,
                    ),
                  )
                ],
              ),
            )));
  }
}
