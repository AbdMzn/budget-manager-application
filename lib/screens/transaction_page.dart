import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '/screens/category_page.dart';
import '/logic/appstate.dart';

class TransactionPage extends StatefulWidget {
  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  TextEditingController _title = TextEditingController();
  TextEditingController _value = TextEditingController();
  TextEditingController _date = TextEditingController();
  TextEditingController _category = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    _category.text = appState.category;

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          centerTitle: true,
          title: Text('New Transaction'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.check),
              tooltip: 'Confirm',
              onPressed: () {
                Navigator.pop(context);
                if (appState.transactionExpense) {
                  appState.newRecord(
                      _title.text, -double.parse(_value.text), _date.text);
                } else {
                  appState.newRecord(
                      _title.text, double.parse(_value.text), _date.text);
                }
              },
            ),
          ],
        ),
        body: ListView(
          children: [
            Container(
              height: 520,
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimary,
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.currency_exchange_rounded,
                          size: 32,
                          color: Theme.of(context).colorScheme.secondary),
                      Container(
                        width: 5,
                      ),
                      Text(
                        'Transaction',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          height: 1.1,
                          fontFamily: 'Poppins',
                          fontSize: 24.0,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Title',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 10, left: 10, right: 10, top: 5),
                    child: TextField(
                      controller: _title,
                      decoration: InputDecoration(
                        isDense: true,
                        labelText: 'Enter Title',
                        prefixIcon: Icon(Icons.text_fields),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 0.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Value',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 10, left: 10, right: 10, top: 5),
                    child: TextField(
                      controller: _value,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d*$'),
                        ),
                      ],
                      decoration: InputDecoration(
                        isDense: true,
                        labelText: 'Enter Amount',
                        prefixIcon: Icon(Icons.attach_money),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Date',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 10, left: 10, right: 10, top: 5),
                    child: TextField(
                      controller: _date,
                      decoration: InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.calendar_today_rounded),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                      ),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101));

                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('dd/MM/yyyy').format(pickedDate);

                          setState(() {
                            _date.text = formattedDate;
                          });
                        } else {
                          print('Date is not selected');
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Category',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        bottom: 10, left: 10, right: 10, top: 5),
                    child: TextField(
                      readOnly: true,
                      controller: _category,
                      decoration: InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.arrow_downward),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                      ),
                      onTap: () {
                        print('Category tapped');

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryPage(),
                          ),
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        iconSize: 60,
                        icon: const Icon(Icons.keyboard_double_arrow_right),
                        tooltip: 'Expense',
                        isSelected: appState.transactionExpense,
                        color: appState.transactionExpense
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.secondary,
                        disabledColor: Theme.of(context).colorScheme.primary,
                        onPressed: () {
                          appState.optionExpense();
                          appState.transactionExpense = true;
                        },
                      ),
                      Container(width: 32),
                      IconButton(
                        iconSize: 60,
                        icon: const Icon(Icons.keyboard_double_arrow_left),
                        tooltip: 'Income',
                        isSelected: !appState.transactionExpense,
                        color: !appState.transactionExpense
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.secondary,
                        onPressed: () {
                          appState.optionIncome();
                          appState.transactionExpense = false;
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Expense',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                      Container(width: 56),
                      Text(
                        'Income',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
