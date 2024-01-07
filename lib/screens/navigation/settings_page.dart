import 'package:budget_manager_application/logic/appstate.dart';
import 'package:budget_manager_application/screens/navigation/new_wallet.dart';
import 'package:budget_manager_application/screens/navigation/wallet_selection_page.dart';
import 'package:budget_manager_application/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  final User? user;
  final Function? updateData;
  const SettingsPage({super.key, this.user, this.updateData});
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final AuthService _auth = AuthService();
  var logger = Logger();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: ListView(
        children: [
          ElevatedButton(
            onPressed: () {
              logger.i("Settings Page User ID: ${widget.user?.uid}");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WalletSelectPage(user: widget.user),
                ),
              ).then((value) {
                var trigger = value ?? false;
                if (trigger) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangeNotifierProvider(
                        create: (context) => AppState(),
                        child: NewWallet(user: widget.user),
                      ),
                    ),
                  ).then((trigger) {
                    widget.updateData!();
                  });
                } else {
                  widget.updateData!();
                }
              });
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Theme.of(context).colorScheme.primary,
                minimumSize: const Size(double.infinity, 80),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                )),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.wallet_rounded, size: 32),
                    SizedBox(width: 8),
                    Text(
                      'Wallets',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                Icon(Icons.keyboard_arrow_right),
              ],
            ),
          ),
          Container(
            height: 8,
          ),
          ElevatedButton(
            onPressed: () async {
              await _auth.signOut();
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color.fromARGB(255, 129, 11, 11),
                minimumSize: const Size(double.infinity, 80),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                )),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.exit_to_app_rounded, size: 32),
                    SizedBox(width: 8),
                    Text(
                      'Logout',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
