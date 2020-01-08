import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    home: ImcCalculator(),
  ));
}

class ImcCalculator extends StatefulWidget {
  @override
  _ImcCalculatorState createState() => _ImcCalculatorState();
}

class _ImcCalculatorState extends State<ImcCalculator> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  String textResult = "";
  GlobalKey<FormState> myformstate = GlobalKey<FormState>();

  void _resetfields() {
    weightController.text = "";
    heightController.text = "";

    setState(() {
      textResult = "";
      myformstate = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text) / 100;

    double result = weight / (height * height);

    print("click      $result");

    setState(() {
      if (result > 18.5 && result < 24.99) {
        print("Peso normal!");
        textResult = "Peso normal (${result.toStringAsPrecision(4)})";
      }
      if (result > 25 && result < 29.99) {
        print("Acima do peso!");
        textResult = "Acima do peso (${result.toStringAsPrecision(4)})";
      }
      if (result > 30 && result < 34.99) {
        print("Ta gordão!");
        textResult = "Ta gordão (${result.toStringAsPrecision(4)})";
      }
      if (result > 35 && result < 39.99) {
        print("Ta super Gordão (${result.toStringAsPrecision(4)})");
        textResult = "Ta super Gordão!";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          backgroundColor: Colors.deepOrange,
          centerTitle: true,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.refresh), onPressed: _resetfields)
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: Form(
            key: myformstate,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(Icons.person_pin, size: 120.0, color: Colors.deepOrange),
                Container(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text("Informe os dados:",
                      style:
                          TextStyle(color: Colors.deepOrange, fontSize: 20.0),
                      textAlign: TextAlign.center),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Peso (Kg)",
                      labelStyle: TextStyle(color: Colors.deepOrange)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.deepOrange, fontSize: 25.0),
                  controller: weightController,
                  validator: (formValueWeight) {
                    if (formValueWeight.isEmpty) {
                      return "insira o peso!";
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Altura (cm)",
                      labelStyle: TextStyle(color: Colors.deepOrange)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.deepOrange, fontSize: 25.0),
                  controller: heightController,
                  validator: (formValueHeight) {
                    if (formValueHeight.isEmpty) {
                      return "insira o peso!";
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 25.0, 0.0, 20.0),
                  child: Container(
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: () {
                        if (myformstate.currentState.validate()) {
                          _calculate();
                        }
                      },
                      child: Text(
                        "Calcular",
                        style: TextStyle(fontSize: 25.0),
                      ),
                      color: Colors.deepOrange,
                      textColor: Colors.white,
                    ),
                  ),
                ),
                Text("$textResult",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 25.0,
                    ))
              ],
            ),
          ),
        ));
  }
}
