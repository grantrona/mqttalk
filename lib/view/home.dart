import 'package:find_my_device/View/history.dart';
import 'package:find_my_device/View/profile.dart';
import 'package:flutter/material.dart';
import '../globals.dart' as globals;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPageIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  static final List<Widget> _bottomNavOptions = <Widget>[
    Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 30),
          child: Image.asset(
            'assets/images/radar.png',
            height: 225,
            width: 225,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 40),
          child: FractionallySizedBox(
            widthFactor: 0.8,
            child: ElevatedButton.icon(
                icon: const Icon(
                  Icons.bluetooth_searching,
                  size: 35,
                ),
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.all(20)),
                    backgroundColor:
                        MaterialStateProperty.all(globals.colorHighlight),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ))),
                onPressed: () {
                  // TODO
                },
                label: Text(
                  'Begin Searching',
                  style: globals.defaultFontTitleBold,
                )),
          ),
        )
      ],
    ),
    const History(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, //prevents resizing of widgets from keyboard popup
      backgroundColor: globals.colorDark,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: globals.colorHighlight,
        title: const Text("Search"),
        centerTitle: true,
        titleTextStyle: globals.defaultFontHeader,
      ),

      body: Center(
        child: _bottomNavOptions.elementAt(currentPageIndex),
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: globals.colorLight,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.bluetooth_searching_rounded),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: "Logs",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            label: "Account",
          ),
        ],
        currentIndex: currentPageIndex,
        selectedItemColor: globals.colorHighlight,
        onTap: _onItemTapped,
      ),
    );
  }
}
