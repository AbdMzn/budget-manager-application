import 'package:budget_manager_application/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
//import 'package:provider/provider.dart';

class AppState extends ChangeNotifier {
  var logger = Logger();
  String category = '';
  String transactionOption = 'Expense';
  String? walletName = "default";
  bool transactionExpense = true;
  bool _walletsExists = false;
  bool get walletExists => _walletsExists;
  DateTime currentDate = DateTime.now();
  double balance = 0;
  List<String> walletList = [];
  List<dynamic> records = [];
  List<String> titles = [];
  List<double> values = [];
  List<String> dates = [];
/*   Map<String, double> categories = {
      'Rent': 0,
      'Food & Drink': 0,
      'Transportation': 0,
      'Utilities': 0,
      'Shopping': 0,
    }; */
  List<double> categoryValues = [0, 0, 0, 0, 0];
  List<String> categories = [
    'Rent',
    'Food & Drink',
    'Transportation',
    'Utilities',
    'Shopping'
  ];
  List<Color> categoryColors = [
    Colors.orange,
    Colors.green,
    Colors.yellow,
    Colors.purple,
    Colors.red
  ];

  Future<void> initializeAppState(User user) async {
    logger.i("Initializing Appstate");
    await getWalletName(user);
    await getBalance(user);
    await getRecords(user);
    await getWalletList(user);
    setRecordValues(user);
  }

  Future<void> getWalletName(User user) async {
    walletName = await DatabaseService(uid: user.uid).getSelectedWallet();
    notifyListeners();
  }

  Future<void> getBalance(User user) async {
    balance = await DatabaseService(uid: user.uid).getBalance(walletName) ?? 0;
    notifyListeners();
  }

  Future<void> getRecords(User user) async {
    try {
      records = await DatabaseService(uid: user.uid)
              .getTransactionRecords(walletName) ??
          [];
      notifyListeners();
    } catch (e) {
      records = [];
      try {
        notifyListeners();
      } catch (e) {
        logger.e("getRecords notifyListeners error: $e");
      }
    }
  }

  Future<void> getWalletList(User user) async {
    walletList = await DatabaseService(uid: user.uid).walletList() ?? [];
    logger.i("getWalletList Wallet List: $walletList");
    notifyListeners();
  }

  Future<void> checkWalletsExistance(uid) async {
    _walletsExists = await DatabaseService.doesWalletsExist(uid);
    logger.i("A wallet found? $_walletsExists");
    try {
      notifyListeners();
    } catch (e) {
      logger.e("Error calling checkWalletsExistance $e");
    }
  }

  Future<void> selectWallet(uid) async {
    String inputWalletName = walletName ?? 'default';
    await DatabaseService(uid: uid).selectWallet(inputWalletName);
    logger.i("A wallet found? $_walletsExists");

    try {
      notifyListeners();
    } catch (e) {
      logger.e("Error calling checkWalletsExistance $e");
    }
  }

  Future<void> newTransactionRecord(User user, String title, double value,
      String date, String category) async {
    String inputWalletName = walletName ?? 'default';
    await DatabaseService(uid: user.uid)
        .newTransaction(inputWalletName, title, value, date, category);
    notifyListeners();
  }

  Future<void> setRecordValues(user) async {
    await getRecords(user);
    double num = 0;
    int index = 0;
    dates = [];
    titles = [];
    values = [];
    categoryValues = [0, 0, 0, 0, 0];
    for (var entry in records) {
      category = (entry["category"].toString());
      num = double.parse(entry["value"].toString());

      if (num < 0) {
        index = categories.indexOf(category);
        categoryValues[index] = categoryValues[index] - num;
      }

      dates.add(entry["date"].toString());
      titles.add(entry["title"].toString());
      values.add(num);
    }
    logger.i("Set Record Values:");
    logger.i(titles);
    logger.i(values);
    logger.i(dates);
    logger.i("Category values: $categoryValues");
    notifyListeners();
  }

  void optionExpense() {
    transactionOption = 'Expense';
    notifyListeners();
  }

  void optionIncome() {
    transactionOption = 'Income';
    notifyListeners();
  }

/*   void newRecord(String title, double value, String date) {
    titles.add(title);
    values.add(value);
    dates.add(date);
    balance = balance + value;

    if (transactionExpense) {
      var index = categories.indexOf(category);
      categoryValues[index] = categoryValues[index] - value;
    }

    notifyListeners();
  } */

  void setCategory(String item) {
    category = item;
    notifyListeners();
  }
}
