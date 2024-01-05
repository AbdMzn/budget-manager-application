import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '/logic/appstate.dart';

class OverviewPage extends StatefulWidget {
  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    var balance = appState.balance.toString();
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20, top: 10),
          padding: const EdgeInsets.only(left: 10.0, top: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.currency_exchange_rounded,
                      size: 28, color: Theme.of(context).colorScheme.secondary),
                  Container(
                    width: 6,
                  ),
                  Text(
                    'Balance',
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
              Row(
                children: [
                  Container(
                    width: 3,
                  ),
                  Text(
                    '\$$balance',
                    style: TextStyle(
                      height: 1.1,
                      fontFamily: 'Poppins',
                      fontSize: 32.0,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
              Container(
                height: 10,
              ),
              Container(),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20, top: 10),
          padding: const EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.assessment_outlined,
                          size: 32,
                          color: Theme.of(context).colorScheme.secondary),
                      Container(
                        width: 5,
                      ),
                      Text(
                        'Expense Structure',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          height: 1.1,
                          fontFamily: 'Poppins',
                          fontSize: 18.0,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 20,
                ),
                Center(
                  child: SizedBox(
                    width: 200,
                    height: 225,
                    child: PieChart(PieChartData(
                      sectionsSpace: 0,
                      borderData: FlBorderData(show: false),
                      sections: List.generate(
                        appState.categoryValues.length,
                        (index) => PieChartSectionData(
                          value: appState.categoryValues[index],
                          color: appState.categoryColors[index],
                          title: '',
                          radius: 30,
                        ),
                      ),
                    )),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Wrap(
                        children:
                            List.generate(appState.categories.length, (index) {
                      if (appState.categoryValues[index] > 0) {
                        return FittedBox(
                          child: Row(
                            children: [
                              Container(width: 4),
                              CircleAvatar(
                                backgroundColor: appState.categoryColors[index],
                                radius: 5,
                              ),
                              Container(
                                width: 3,
                              ),
                              Text(
                                appState.categories[index],
                                style: const TextStyle(fontSize: 10),
                              ),
                              Container(width: 4),
                            ],
                          ),
                        );
                      } else {
                        return Container(
                          width: 0,
                        );
                      }
                    })),
                  ),
                ),
                Container(
                  height: 55,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
