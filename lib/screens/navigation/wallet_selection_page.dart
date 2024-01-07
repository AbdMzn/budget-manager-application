import 'package:budget_manager_application/logic/appstate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class WalletSelectPage extends StatefulWidget {
  final User? user;
  const WalletSelectPage({super.key, this.user});

  @override
  State<WalletSelectPage> createState() => _WalletSelectPageState();
}

class _WalletSelectPageState extends State<WalletSelectPage> {
  var logger = Logger();
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    logger.i("User id: ${widget.user?.uid}");
    logger.i("wallets: ${appState.walletList}");
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        centerTitle: true,
        title: const Text('Select wallet'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: appState.walletList.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        appState.walletName = appState.walletList[index];
                        logger
                            .i("Walletlist page user id: ${widget.user?.uid}");
                        await appState.selectWallet(widget.user?.uid);
                        Navigator.pop(context, false);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.onPrimary,
                        foregroundColor: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: const Size(double.infinity, 80),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.wallet_rounded,
                            color: Theme.of(context).colorScheme.primary,
                            size: 40,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            appState.walletList[index],
                            style: TextStyle(
                              fontSize: 22,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context, true);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.onPrimary,
              foregroundColor: Theme.of(context).colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              minimumSize: const Size(double.infinity, 80),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.add_rounded,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  "New Wallet",
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
