import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CalculatorHome(),
    );
  }
}

class CalculatorHome extends StatefulWidget {
  const CalculatorHome({super.key});

  @override
  State<CalculatorHome> createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  String equation = '0';
  String expression = '0';
  String result = '';

  buttonPressed(btnText) {
    setState(() {
      if (btnText == 'AC') {
        equation = '0';
        result = '0';
      } else if (btnText == '⌫') {
        equation = equation.substring(0, equation.length - 1);

        if (equation == '') {
          equation = '0';
        }
      } else if (btnText == '=') {
        expression = equation;
        expression = expression.replaceAll('x', '*');
        expression = expression.replaceAll('÷', '/');
        expression = expression.replaceAll(',', '.');
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          'Error';
        }
      } else {
        if (equation == '0') {
          equation = btnText;
        } else {
          equation = equation + btnText;
        }
      }

      if (btnText == ',' && !equation.contains(',')) {
        equation += '.';
      }
    });
  }

  Widget calcButtons(
      String btnText, Color txtColor, double btnWidth, Color btnColor) {
    return InkWell(
      onTap: () {
        buttonPressed(btnText);
      },
      child: Container(
        alignment: Alignment.center,
        height: 66,
        width: btnWidth,
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          btnText,
          style: TextStyle(
              color: txtColor, fontSize: 24, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Calculator',
          style: TextStyle(
              color: Colors.white, fontSize: 28, fontWeight: FontWeight.w400),
        ),
        shape: const Border(bottom: BorderSide(color: Colors.grey, width: 1.0)),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 14,
          ),
          Container(
            height: 80,
            width: double.infinity,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            color: Colors.black,
            child: SingleChildScrollView(
              child: Text(
                equation,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 38,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
            height: 80,
            width: double.infinity,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            color: Colors.black,
            child: SingleChildScrollView(
              child: Text(
                result,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 60,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    calcButtons(
                        'AC', Colors.white, 66, Colors.deepOrangeAccent[100]!),
                    calcButtons('⌫', Colors.white, 66, Colors.white38),
                    calcButtons('%', Colors.white, 66, Colors.white38),
                    calcButtons(
                        '÷', Colors.white, 66, Colors.deepOrangeAccent[100]!),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    calcButtons('7', Colors.white, 66, Colors.white10),
                    calcButtons('8', Colors.white, 66, Colors.white10),
                    calcButtons('9', Colors.white, 66, Colors.white10),
                    calcButtons(
                        'x', Colors.white, 66, Colors.deepOrangeAccent[100]!),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    calcButtons('4', Colors.white, 66, Colors.white10),
                    calcButtons('5', Colors.white, 66, Colors.white10),
                    calcButtons('6', Colors.white, 66, Colors.white10),
                    calcButtons(
                        '-', Colors.white, 66, Colors.deepOrangeAccent[100]!),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    calcButtons('1', Colors.white, 66, Colors.white10),
                    calcButtons('2', Colors.white, 66, Colors.white10),
                    calcButtons('3', Colors.white, 66, Colors.white10),
                    calcButtons(
                        '+', Colors.white, 66, Colors.deepOrangeAccent[100]!),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    calcButtons('0', Colors.white, 152, Colors.white10),
                    calcButtons(',', Colors.white, 66, Colors.white10),
                    calcButtons(
                        '=', Colors.white, 66, Colors.deepOrangeAccent[100]!),
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
