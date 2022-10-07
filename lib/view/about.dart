import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../globals.dart' as globals;

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  final Uri _mosqUrl = Uri.parse("https://mosquitto.org/");
  final Uri _client = Uri.parse("https://pub.dev/publishers/darticulate.com/packages");
  final Uri _provider = Uri.parse("https://pub.dev/publishers/dash-overflow.net/packages");
   final Uri _jsonSerialise = Uri.parse("https://opensource.google/");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, //prevents resizing of widgets from keyboard popup
      backgroundColor: globals.colorDark,
      appBar: AppBar(
        backgroundColor: globals.colorHighlight,
        title: const Text("About"),
        centerTitle: true,
        titleTextStyle: globals.defaultFontHeader,
      ),

      body: Center(
        child: Column(children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Text(
              "Credits",
              style: globals.defaultFontTitle,
            ),
          ),
          Container(
            padding:const EdgeInsets.all(10),
            child: Text(
              "Special thanks to the creaters and contributers of these open source libraries:",
              style: globals.buttonFontText,
              textAlign: TextAlign.center,
            ),
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(5.0),
                child: TextButton(onPressed: () {
                  _launchUrl(_mosqUrl);
                },
                 child: Text("mosquitto.org", style: globals.linkText),
                 ),
              ),
              Container(
                padding: const EdgeInsets.all(5.0),
                child: TextButton(
                  onPressed: () {
                    _launchUrl(_provider);
                  },
                  child: Text("dash-overflow.net", style: globals.linkText),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5.0),
                child: TextButton(
                  onPressed: () {
                    _launchUrl(_client);
                  },
                  child: Text("darticulate.com", style: globals.linkText),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5.0),
                child: TextButton(
                  onPressed: () {
                    _launchUrl(_jsonSerialise);
                  },
                  child: Text("opensource.google", style: globals.linkText),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }
}
