import 'package:budget_manager_application/logic/appstate.dart';
import 'package:budget_manager_application/screens/new_wallet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class NoWallet extends StatefulWidget {
  final User? user;
  final Function? updateData;
  const NoWallet({super.key, this.user, this.updateData});
  @override
  State<NoWallet> createState() => _NoWalletState();
}

class _NoWalletState extends State<NoWallet> {
  var logger = Logger();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          IconButton(
            onPressed: () {
              logger.i("NoWallet User ID: ${widget.user?.uid}");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                    create: (context) => MyAppState(),
                    child: NewWallet(user: widget.user),
                  ),
                ),
              ).then((value) {
                widget.updateData!();
              });
            },
            icon: const Icon(
              Icons.add_circle_outline,
              size: 120,
              color: Colors.grey,
            ),
          ),
          const Text(
            "Create New Wallet",
            style: TextStyle(
                color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
