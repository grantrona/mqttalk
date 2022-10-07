import 'package:find_my_device/controller/auth.dart';
import 'package:flutter/material.dart';
import '../globals.dart' as globals;

class ManageEmail extends StatefulWidget {
  const ManageEmail({super.key});

  @override
  State<ManageEmail> createState() => _ManageEmailState();
}

class _ManageEmailState extends State<ManageEmail> {
  final _checkPasswordController = TextEditingController();
  final _newEmailController = TextEditingController();
  final _confirmEmailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _validPassword = true;
  bool _validEmail = true;
  String _authErrorCode = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: globals.colorHighlight,
        title: const Text("Manage Email"),
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
                            textInputAction: TextInputAction.next,
                            obscureText: true,
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
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            controller: _newEmailController,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: globals.colorLight,
                                hintText: "Enter new Email Address",
                                errorText: _validEmail ? null : ""),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            controller: _confirmEmailController,
                            validator: (confirmValue) {
                              if (_newEmailController.text != confirmValue) {
                                return "Emails do not match, please try entering them again";
                              }
                              if (_newEmailController.text == "" ||
                                  confirmValue == "") {
                                return "Password fields are empty";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: globals.colorLight,
                              hintText: "Confirm your new Email Address",
                              errorText: _validEmail ? null : _authErrorCode,
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
                                    _authErrorCode = await Auth()
                                        .updateUserEmail(
                                            _newEmailController.text);

                                    if (_authErrorCode != "") {
                                      _validEmail = false;
                                      setState(() {});
                                      return;
                                    }

                                    if (!mounted) {
                                      return;
                                    }
                                    Navigator.of(context).pop();
                                  }
                                },
                                child: Text(
                                  "Submit Email",
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
