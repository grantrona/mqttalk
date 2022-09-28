import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// Defuault values are used until sign in has occured -> Load preferences after sign in
import '../globals.dart' as globals;

class StartUp extends StatelessWidget {
  const StartUp({super.key});

  // escapes the 'No MediaQuery widget found' error
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: Login()     
        );
  }
}

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset:
            false, //prevents resizing of widgets from keyboard popup
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue.shade800,
          title: const Text("Login"),
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
                flex: 1,
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
                flex: 2,
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
                          ))
                    ],
                    color: Colors.white,
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
                              fillColor: Colors.white),
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
                              fillColor: Colors.white),
                        ),
                      ),
                      TextButton (
                        child: const Text(
                          "Forgot password?",
                          style: TextStyle(color: Colors.black54),
                          ),
                        onPressed: () {
                          // TODO
                        },
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
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ))),
                              onPressed: () {
                                // TODO
                              },
                              child: Text(
                                'Sign in',
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
                child: TextButton (
                        child: Text(
                          "New User? Register here!",
                          style: GoogleFonts.lato(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        onPressed: () {
                          // TODO
                        },
                      ),  
              )
            ],
          ),
        ),
      ),
    );
  }
}
