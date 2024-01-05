import 'package:budget_manager_application/services/auth.dart';
import 'package:budget_manager_application/shared/constants.dart';
import 'package:budget_manager_application/shared/loading.dart';
//import 'package:budget_manager_application/logic/appstate.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class Register extends StatefulWidget {
  final Function? toggleView;
  const Register({super.key, this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  var logger = Logger();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      backgroundColor: Colors.blue,
      textStyle: const TextStyle(fontSize: 20),
      minimumSize: const Size(400, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
    );
    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            /* appBar: AppBar(
              backgroundColor: Colors.blue[400],
              elevation: 0.0,
              title: const Text('Sign up'),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.person),
                  onPressed: () => widget.toggleView!(),
                ),
              ],
            ), */
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 40),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 50.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 20.0),
                        TextFormField(
                          decoration:
                              textInputDecoration.copyWith(hintText: 'Email'),
                          validator: (val) =>
                              val!.isEmpty ? 'Enter an email' : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Password'),
                          obscureText: true,
                          validator: (val) => val!.length < 8
                              ? 'password must be atleast 8 characters long'
                              : null,
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                        ),
                        const SizedBox(height: 40.0),
                        ElevatedButton(
                            style: style,
                            child: const Text(
                              'Register',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() => loading = true);
                                dynamic result =
                                    await _auth.registerWithEmailAndPassword(
                                        email, password);
                                if (result == null) {
                                  try {
                                    setState(() {
                                      loading = false;
                                      error = 'Please supply a valid email';
                                    });
                                  } catch (e) {
                                    logger.e(
                                        "Error setting loading screen to false $e");
                                  }
                                }
                              }
                            }),
                        const SizedBox(height: 12.0),
                        Text(
                          error,
                          style: const TextStyle(
                              color: Colors.red, fontSize: 14.0),
                        ),
                        const SizedBox(height: 12.0),
                        TextButton(
                          child: const Text(
                            "Already have an account? Sign in.",
                            style:
                                TextStyle(color: Colors.blue, fontSize: 14.0),
                          ),
                          onPressed: () => widget.toggleView!(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
