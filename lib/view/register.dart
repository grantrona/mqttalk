import 'package:find_my_device/controller/auth.dart';
import 'package:flutter/material.dart';
// Defuault values are used until sign in has occured -> Load preferences after sign in
import '../globals.dart' as globals;
import '../shared/alert.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

/// Allow users to register their credentials using firebase auth
class _RegisterState extends State<Register> {
  // Text controllers used to store/read text from text input fields
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  // booleans used to check if inputs are valid
  bool _passwordsMatch = true;
  bool _validEmail = true;

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
                          Icons.chat_bubble_outlined,
                          size: 50,
                          color: Colors.blue,
                        ),
                        Text(
                          "ChatterBox",
                          style: globals.defaultFontTitle,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
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

                    // Text inputs for email and passoword
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
                                fillColor: globals.colorLight,
                                errorText: _validEmail
                                    ? null
                                    : "Email already in use or is invalid"),
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
                                fillColor: globals.colorLight,
                                errorText: _passwordsMatch ? null : ""),
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
                                fillColor: globals.colorLight,
                                errorText: _passwordsMatch
                                    ? null
                                    : "Passwords do not match"),
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
                                onPressed: () async {
                                  // Determine if user has filled in all the fields or not
                                  if (_emailController.text.isEmpty ||
                                      _confirmController.text.isEmpty ||
                                      _passwordController.text.isEmpty) {
                                    showAlertDialog(
                                        context, "Please fill all the fields!");
                                    return;
                                  }
                                  // Check if passwords in both text fields match 
                                  if (_confirmController.text !=
                                      _passwordController.text) {
                                    _passwordsMatch = false;
                                    setState(() {});
                                    return;
                                  }

                                  // attempt to use firebase auth to register a new user
                                  _validEmail = await Auth().register(_emailController.text.trim(),
                                      _passwordController.text.trim(), context);
                                  setState(() {
                                    
                                  });
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
