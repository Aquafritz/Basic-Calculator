// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  late String _output;
  late String _outputHistory;
  late double _num1;
  late double _num2;
  late String _operand;

  @override
  void initState() {
    super.initState();
    _output = "0";
    _outputHistory = "";
    _num1 = 0;
    _num2 = 0;
    _operand = "";
  }

 void _buttonPressed(String buttonText) {
  if (buttonText == "C") {
    _output = "0";
    _outputHistory = "";
    _num1 = 0;
    _num2 = 0;
    _operand = "";
  } else if (buttonText == "+" || buttonText == "-" || buttonText == "x" || buttonText == "/") {
    if (_output != "0") {
      _num1 = double.parse(_output);
      _operand = buttonText;
      _outputHistory = _output + buttonText;
      _output = "0"; // Reset _output only after the first operand
    }
  } else if (buttonText == "=") {
    _num2 = double.parse(_output);
    if (_operand == "+") {
      _output = (_num1 + _num2).toString();
    }
    if (_operand == "-") {
      _output = (_num1 - _num2).toString();
    }
    if (_operand == "x") {
      _output = (_num1 * _num2).toString();
    }
    if (_operand == "/") {
      _output = (_num1 / _num2).toString();
    }

    _operand = "";
    _num1 = 0;
    _num2 = 0;
    _outputHistory = "";
  } else {
    if (_output == "0" || _output == "0.0") {
      _output = buttonText;
    } else {
      _output += buttonText;
    }
  }

  setState(() {});
}


  Widget buildButton(String buttonText) {
    Color textColor =  Colors.white;
    Color buttonColor = (buttonText == "C") ? Colors.red : (Colors.grey.shade600);

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
          ),
          onPressed: () {
            _buttonPressed(buttonText);
          },
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: textColor),
          ),
        ),
      ),
    );
  }

@override
Widget build(BuildContext context) {
  Color backgroundColor = Colors.amber; // Set background color to amber
  Color outputColor = Colors.black;
  return Container(
    color: backgroundColor, // Set container color
    child: Center(
      child: Container(
        width: 600,
        height: 900,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Calculator'),
            centerTitle: true,
            backgroundColor: backgroundColor,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomRight,
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      _outputHistory,
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: outputColor),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    _output,
                    style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold, color: outputColor),
                  ),
                ),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.grey[800],
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          buildButton("1"),
                          buildButton("2"),
                          buildButton("3"),
                          buildButton("/"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          buildButton("4"),
                          buildButton("5"),
                          buildButton("6"),
                          buildButton("x"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          buildButton("7"),
                          buildButton("8"),
                          buildButton("9"),
                          buildButton("-"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          buildButton("."),
                          buildButton("0"),
                          buildButton("00"),
                          buildButton("+"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          buildButton("C"),
                          buildButton("="),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
}