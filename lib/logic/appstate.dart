import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  var transactionOption = 'Expense';
  var balance = 2000.0;
  var category = '';
  var transactionExpense = true;
  DateTime currentDate = DateTime.now();
  List<String> titles = [];
  List<double> values = [];
  List<String> dates = [];
  List<String> categories = [
    'Rent',
    'Food & Drink',
    'Transportation',
    'Utilities',
    'Shopping'
  ];
  List<double> categoryValues = [0, 0, 0, 0, 0];
  List<Color> categoryColors = [
    Colors.orange,
    Colors.green,
    Colors.yellow,
    Colors.purple,
    Colors.red
  ];
  void optionExpense() {
    transactionOption = 'Expense';
    notifyListeners();
  }

  void optionIncome() {
    transactionOption = 'Income';
    notifyListeners();
  }

  void newRecord(String title, double value, String date) {
    titles.add(title);
    values.add(value);
    dates.add(date);
    balance = balance + value;

    if (transactionExpense) {
      var index = categories.indexOf(category);
      categoryValues[index] = categoryValues[index] - value;
    }

    notifyListeners();
  }

  void setCategory(String item) {
    category = item;
    print(category);
    notifyListeners();
  }
}
