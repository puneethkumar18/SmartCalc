import 'package:business_calculator/controllers/calculator_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CalculatorScreen extends StatelessWidget {
  CalculatorScreen({super.key});

  final List<String> buttons = [
    "",
    "AC",
    "⌫",
    "/",
    "7",
    "8",
    "9",
    "*",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
    "00",
    "0",
    ".",
    "="
  ];

  @override
  Widget build(BuildContext context) {
    final calculatorController = Provider.of<CalculatorController>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          "Calculator",
          style: TextStyle(
            color: Colors.blueAccent,
            fontSize: 30,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                alignment: Alignment.bottomRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.none,
                      autofocus: true,
                      controller: calculatorController.controller,
                      textAlign: TextAlign.right,
                      cursorColor: Colors.blueAccent,
                      maxLines: calculatorController.len < 6 ? 1 : 2,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: calculatorController.len < 6 ? 70 : 40,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.transparent,
                        )),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.transparent,
                        )),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.transparent,
                        )),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      calculatorController.result,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: buttons.length,
                  itemBuilder: (context, index) {
                    return buttons[index].isEmpty
                        ? const SizedBox.shrink()
                        : ElevatedButton(
                            onPressed: () =>
                                calculatorController.input(buttons[index]),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _getButtonColor(buttons[index]),
                              minimumSize: Size.fromHeight(10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              buttons[index],
                              style: TextStyle(
                                fontSize: _getIconSize(buttons[index]),
                                color: Colors.white,
                              ),
                            ),
                          );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getButtonColor(String button) {
    if (button == "AC" || button == "⌫") return Colors.grey.shade900;
    if (button == "=") return Colors.blueAccent;
    if (button == "/" || button == "*" || button == "-" || button == "+") {
      return Colors.blueAccent;
    }
    return Colors.grey.shade900;
  }

  double _getIconSize(String button) {
    if (button == "Ac" || button == "⌫") return 30;
    if (button == "=") return 30;
    if (button == '.') return 40;
    if (button == "/" || button == "*" || button == "-" || button == "+") {
      return 34;
    }
    return 20;
  }
}
