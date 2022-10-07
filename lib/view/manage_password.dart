import 'package:find_my_device/controller/auth.dart';
import 'package:flutter/material.dart';
import '../globals.dart' as globals;

class ManagePassword extends StatefulWidget {
  const ManagePassword({super.key});

  @override
  State<ManagePassword> createState() => _ManagePasswordState();
}

class _ManagePasswordState extends State<ManagePassword> {
  final _checkPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _validPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: globals.colorHighlight,
        title: const Text("Reset Password"),
        centerTitle: true,
        titleTextStyle: globals.defaultFontHeader,
      ),
      backgroundColor: globals.colorDark,
      body: Center(
        child: Column(
          children: [
            Flexible(
                child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            obscureText: true,
                            textInputAction: TextInputAction.next,
                            controller: _checkPasswordController,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: globals.colorLight,
                                hintText: "Re-type your Password",
                                errorText: _validPassword
                                    ? null
                                    : "Inputted password is incorrect!"),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            obscureText: true,
                            controller: _newPasswordController,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                                filled: true,
                                fillColor: globals.colorLight,
                                hintText: "Enter new password"),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            obscureText: true,
                            textInputAction: TextInputAction.next,
                            controller: _confirmPasswordController,
                            validator: (confirmValue) {
                              if (_newPasswordController.text != confirmValue) {
                                return "Passwords do not match, please try entering them again";
                              }
                              if (_newPasswordController.text == "" ||
                                  confirmValue == "") {
                                return "Password fields are empty";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: globals.colorLight,
                              hintText: "Confirm your new password",
                            ),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: 0.6,
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: ElevatedButton(
                                style: globals.profileButton,
                                onPressed: () async {
                                  _validPassword = await Auth()
                                      .validatePassword(
                                          _checkPasswordController.text);

                                  setState(() {});

                                  if (_formKey.currentState!.validate() &&
                                      _validPassword) {
                                    if (!mounted) {
                                      return;
                                    }
                                    Auth().updateUserPassword(
                                        _newPasswordController.text);
                                    Navigator.of(context).pop();
                                  }
                                },
                                child: Text(
                                  "Submit Password",
                                  style: globals.buttonFontText,
                                )),
                          ),
                        )
                      ],
                    ))),
          ],
        ),
      ),
    );
  }
}
