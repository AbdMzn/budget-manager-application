import 'package:budget_manager_application/logic/appstate.dart';
import 'package:budget_manager_application/screens/navigation/history_page.dart';
import 'package:budget_manager_application/screens/navigation/transaction_page.dart';
import 'package:budget_manager_application/screens/navigation/settings_page.dart';
import 'package:budget_manager_application/screens/navigation/overview_page.dart';
import 'package:budget_manager_application/screens/no_wallet.dart';
import 'package:budget_manager_application/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final User user;
  const HomePage({super.key, required this.user});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedIndex = 0;
  var pageName = 'Home';
  var logger = Logger();
  bool loaded = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      var appState = context.read<AppState>();
      appState.checkWalletsExistance(widget.user.uid);
      await appState.initializeAppState(widget.user);
      logger.i('walletlist Init: ${appState.walletList}');
      logger.i('Homepage user id: ${widget.user.uid}');
      loaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    var walletExists = appState.walletExists;
    void updateData() async {
      await appState.checkWalletsExistance(widget.user.uid);
      await appState.getWalletName(widget.user);
      await appState.getWalletList(widget.user);
      await appState.getBalance(widget.user);
      await appState.setRecordValues(widget.user);
      logger.i("updateData called");
    }

    var noWalletPage = NoWallet(user: widget.user, updateData: updateData);

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = walletExists ? OverviewPage() : noWalletPage;
        pageName = 'Home';
      case 1:
        page = walletExists ? HistoryPage(user: widget.user) : noWalletPage;
        pageName = 'History';
      case 2:
        //page = walletExists ? const Placeholder() : noWalletPage;
        page = const Placeholder();
        pageName = 'Budget';
      case 3:
        page = SettingsPage(
          user: widget.user,
          updateData: updateData,
        );
        pageName = 'Settings';
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          centerTitle: true,
          title: Text(pageName),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add_rounded),
              tooltip: 'New transaction',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TransactionPage(
                        user: widget.user, updateData: updateData),
                  ),
                );
              },
            ),
/*             IconButton(
              icon: const Icon(Icons.person),
              tooltip: 'logout',
              onPressed: () async {
                await _auth.signOut();
              },
            ), */
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: loaded ? page : const Loading(),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: true,
          selectedFontSize: 16,
          selectedIconTheme: IconThemeData(
              color: Theme.of(context).colorScheme.onPrimary, size: 32.0),
          items: [
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).colorScheme.primary,
              icon: const Icon(Icons.home_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).colorScheme.primary,
              icon: const Icon(Icons.calendar_today_rounded),
              label: 'History',
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).colorScheme.primary,
              icon: const Icon(Icons.insert_chart_outlined_outlined),
              label: 'Budget',
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).colorScheme.primary,
              icon: const Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          currentIndex: selectedIndex,
          onTap: (value) {
            setState(() {
              selectedIndex = value;
              appState.checkWalletsExistance(widget.user.uid);
            });
          },
        ),
      );
    });
  }
}
