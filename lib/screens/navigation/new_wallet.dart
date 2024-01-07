import 'package:budget_manager_application/services/database.dart';
import 'package:budget_manager_application/shared/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:budget_manager_application/shared/constants.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

class NewWallet extends StatefulWidget {
  final User? user;
  const NewWallet({super.key, this.user});

  @override
  State<NewWallet> createState() => _NewWalletState();
}

class _NewWalletState extends State<NewWallet> {
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  String walletName = '';
  double balance = 0;
  var logger = Logger();

  @override
  Widget build(BuildContext context) {
    //var appState = context.watch<MyAppState>();
    final ButtonStyle style = ElevatedButton.styleFrom(
      backgroundColor: Colors.blue,
      textStyle: const TextStyle(fontSize: 20),
      minimumSize: const Size(400, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        centerTitle: true,
        title: const Text('New Wallet'),
      ),
      body: ListView(
        children: [
          PrimaryContainer(
            icon: Icons.wallet,
            title: "New Wallet",
            iconSize: 38,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Wallet name'),
                      validator: (val) =>
                          val!.isEmpty ? 'Enter wallet name' : null,
                      onChanged: (val) {
                        setState(() => walletName = val);
                      },
                    ),
                    Container(height: 20),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Balance'),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d{0,2}$'),
                        ),
                      ],
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Enter balance';
                        }
                        if (double.tryParse(val) == null) {
                          return 'Enter a valid number';
                        }
                        return null;
                      },
                      onChanged: (val) {
                        try {
                          setState(() => balance = double.parse(val));
                        } catch (e) {
                          logger.e("must enter number $e");
                        }
                      },
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                        style: style,
                        child: const Text(
                          'Create Wallet',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() => loading = true);
                            logger.i("User ID: ${widget.user?.uid}");
                            bool result =
                                await DatabaseService(uid: widget.user?.uid)
                                    .createNewWallet(
                              walletName,
                              balance,
                            );
                            if (result == false) {
                              setState(() {
                                loading = false;
                                error =
                                    'Could not create wallet, try a different name';
                              });
                            } else {
                              Navigator.pop(context);
                            }
                          }
                        }),
                    const SizedBox(height: 12.0),
                    Text(
                      error,
                      style: const TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
