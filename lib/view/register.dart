import 'package:find_my_device/view_model/services/auth.dart';
import 'package:find_my_device/view/search.dart';
import 'package:flutter/material.dart';
// Defuault values are used until sign in has occured -> Load preferences after sign in
import '../globals.dart' as globals;
import '../shared/alert.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: globals.colorDark,
      appBar: AppBar(
        backgroundColor: globals.colorHighlight,
        title: const Text("Register"),
        centerTitle: true,
        titleTextStyle: globals.defaultFontHeader,
      ),

      // Container for Welcome message
      body: Center(
        child: CustomScrollView(slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.bluetooth_searching,
                          size: 50,
                          color: Colors.blue,
                        ),
                        Text(
                          "FindMyDevice",
                          style: globals.defaultFontTitle,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black45,
                            blurRadius: 25.0,
                            spreadRadius: 5.0,
                            offset: Offset(
                              15.0,
                              15.0,
                            )),
                      ],
                      color: globals.colorLight,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            controller: _emailController,
                            decoration: InputDecoration(
                                border: const UnderlineInputBorder(),
                                labelText: 'Email',
                                labelStyle: globals.defaultFontText,
                                prefixIcon: const Icon(Icons.person),
                                fillColor: globals.colorLight),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          child: TextFormField(
                            obscureText: true,
                            textInputAction: TextInputAction.next,
                            controller: _passwordController,
                            decoration: InputDecoration(
                                border: const UnderlineInputBorder(),
                                labelText: 'Password',
                                labelStyle: globals.defaultFontText,
                                prefixIcon: const Icon(Icons.lock),
                                fillColor: globals.colorLight),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          child: TextFormField(
                            obscureText: true,
                            controller: _confirmController,
                            decoration: InputDecoration(
                                border: const UnderlineInputBorder(),
                                labelText: 'Confirm Password',
                                labelStyle: globals.defaultFontText,
                                prefixIcon: const Icon(Icons.lock),
                                fillColor: globals.colorLight),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: FractionallySizedBox(
                            widthFactor: 0.8,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                            const EdgeInsets.all(15)),
                                    backgroundColor: MaterialStateProperty.all(
                                        globals.colorHighlight),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ))),
                                onPressed: () {
                                  if (_emailController.text.isEmpty ||
                                      _confirmController.text.isEmpty ||
                                      _passwordController.text.isEmpty) {
                                    showAlertDialog(
                                        context, "Please fill all the fields!");
                                    return;
                                  }
                                  if (_confirmController.text !=
                                      _passwordController.text) {
                                    showAlertDialog(
                                        context, "Passwords do not match!");
                                    _confirmController.clear();
                                    _passwordController.clear();
                                    return;
                                  }
                                  Auth().register(_emailController.text.trim(),
                                      _passwordController.text.trim(), context);
                                },
                                child: Text(
                                  'Register',
                                  style: globals.buttonFontText,
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
