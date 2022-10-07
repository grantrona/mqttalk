import 'package:find_my_device/controller/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
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
                      children: [
                        TextFormField(
                          // obscureText: true,
                          controller: _checkPasswordController,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: globals.colorLight,
                              hintText: "Re-type your Password",
                              errorText: _validPassword
                                  ? null
                                  : "Inputted password is incorrect!"),
                        ),
                        TextFormField(
                          // obscureText: true,
                          controller: _newPasswordController,
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: globals.colorLight,
                              hintText: "Enter new password"),
                        ),
                        TextFormField(
                          // obscureText: true,
                          controller: _confirmPasswordController,
                          validator: (confirmValue) {
                            if (_newPasswordController.text !=
                                confirmValue) {
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
                      ],
                    ))),
            ElevatedButton(
                onPressed: () async {
                  _validPassword = await Auth()
                      .validatePassword(_checkPasswordController.text);

                  setState(() {});

                  if (_formKey.currentState!.validate() && _validPassword) {
                    if (!mounted) {
                      return;
                    }
                    Auth().updateUserPassword(_newPasswordController.text);
                    Navigator.of(context).pop();
                  }
                },
                child: const Text("Submit Password"))
          ],
        ),
      ),
    );
  }
}
