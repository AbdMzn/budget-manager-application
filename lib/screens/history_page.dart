import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/logic/appstate.dart';
import '../utils/functions.dart';

class HistoryPage extends StatelessWidget {
  final User user;
  const HistoryPage({super.key, required this.user});
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    var titles = appState.titles.toList();
    var values = appState.values.toList();
    var dates = appState.dates.toList();
    List<String> valuesString =
        values.map((intNumber) => '$intNumber\$').toList();

    return Container(
      height: 480,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.calendar_today_rounded,
                    size: 24, color: Theme.of(context).colorScheme.secondary),
                Container(
                  width: 5,
                ),
                Text(
                  'Transaction History',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height: 1.1,
                    fontFamily: 'Poppins',
                    fontSize: 16.0,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              //color: Colors.green,
              width: double.infinity,
              constraints: const BoxConstraints(
                minHeight: 200.0,
              ),
              child: DataTable(
                dataRowMinHeight: 10.0,
                dataRowMaxHeight: 40.0,
                horizontalMargin: 4.0,
                columnSpacing: 25.0,
                columns: const [
                  DataColumn(
                    label: Expanded(
                      child: Center(child: Text('Title')),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Center(child: Text('Value')),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Center(child: Text('Date')),
                    ),
                  ),
                ],
                rows: buildRows(
                  [
                    titles,
                    valuesString,
                    dates,
                  ],
                ),
              ),
            ),
          ),

/*           Padding(
            padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.secondary,
                        width: 1.0,
                      ),
                    ),
                    child: IconButton(
                      color: Theme.of(context).colorScheme.secondary,
                      iconSize: 15,
                      padding: EdgeInsets.only(left: 8, right: 5),
                      onPressed: () {},
                      icon: Icon(Icons.arrow_back_ios),
                    )),
                Container(
                  width: 2,
                ),
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 1.0,
                    ),
                  ),
                  child: TextButton(
                    child: Text(
                      '1',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
                Container(
                  width: 2,
                ),
                Container(
                    width: 30,
                    height: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.secondary,
                        width: 1.0,
                      ),
                    ),
                    child: IconButton(
                      alignment: Alignment.center,
                      color: Theme.of(context).colorScheme.secondary,
                      iconSize: 15,
                      padding: EdgeInsets.only(left: 5, right: 5),
                      onPressed: () {},
                      icon: Icon(Icons.keyboard_control_rounded),
                    )),
                Container(
                  width: 2,
                ),
                Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.secondary,
                        width: 1.0,
                      ),
                    ),
                    child: IconButton(
                      color: Theme.of(context).colorScheme.secondary,
                      iconSize: 15,
                      padding: EdgeInsets.only(left: 8, right: 5),
                      onPressed: () {},
                      icon: Icon(Icons.arrow_forward_ios),
                    )),
              ],
            ),
          ),*/
        ],
      ),
    );
  }
}
