import 'package:find_my_device/view/home.dart';
import 'package:flutter/material.dart';
// Defuault values are used until sign in has occured -> Load preferences after sign in
import '../globals.dart' as globals;

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset:
            false, //prevents resizing of widgets from keyboard popup
        backgroundColor: globals.colorDark,
        appBar: AppBar(
          backgroundColor: globals.colorHighlight,
          title: const Text("Register"),
          centerTitle: true,
          titleTextStyle: globals.defaultFontHeader,
        ),

        // Container for Welcome message
        body: Center(
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
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.all(15)
                                ),
                                backgroundColor: MaterialStateProperty.all(globals.colorHighlight),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ))),
                              onPressed: () {
                                Navigator.push(context,
                                 MaterialPageRoute(builder: (_) => const HomeScreen()));
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
              Expanded (
                flex: 1,
                child: Container(
                ),  
              )
            ],
          ),
        ),
      );
  }
}
