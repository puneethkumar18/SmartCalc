import 'dart:developer';

import 'package:flutter/material.dart';

class CalculatorController extends ChangeNotifier {
  final TextEditingController _controller = TextEditingController();
  double _result = 0;
  int _len = 0;
  double _last = 0;
  String symbol = "";

  TextEditingController get controller => _controller;
  int get len => _len;
  String get result {
    if (_result.toString().split('.').last == "0") {
      return _result.toString().split('.').first;
    }
    return _result.toString();
  }

  void input(String val) {
    if (val == "AC") {
      controller.text = "";
      _result = 0;
      _last = 0;
      symbol = "";
    } else if (val == "⌫") {
      deleteText();
      calculate(val);
    } else if (val == '=') {
      controller.text = result;
      controller.text = controller.text == "0" ? "" : result;
      symbol = "";
    } else {
      insertValue(val);
      calculate(val);
    }
    notifyListeners();
  }

  void calculate(String val) {
    String res = _controller.text;

    log("message");
    log(res);
    if (val != '+' && val != '-' && val != '/' && val != '*' && val != '.') {
      if (val == "⌫") {
        _result -= _last;
      }
      res = res.split(symbol).last;
      _last = double.parse(res);
      switch (symbol) {
        case '+':
          _result += _last;
        case '/':
          _result /= _last;
        case '*':
          _result *= _last;
        case '-':
          _result -= _last;
        default:
          _result = double.parse(controller.text);
      }
    } else {
      if (val != '.') symbol = val;
    }
    log(_result.toString());
  }

  void insertValue(String val) {
    final text = _controller.text;
    final selection = _controller.selection;
    final newText = text.replaceRange(selection.start, selection.end, val);

    _controller.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: selection.start + val.length),
    );
    _len = newText.length;
    log(len.toString());
    log(_controller.text.length.toString());
    notifyListeners();
  }

  void deleteText() {
    final text = _controller.text;
    final selection = _controller.selection;

    if (selection.start > 0) {
      final newText =
          text.replaceRange(selection.start - 1, selection.start, '');
      _controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: selection.start - 1),
      );
    }
    log(_controller.text.length.toString());
    notifyListeners();
  }
}
