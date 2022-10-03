import 'package:find_my_device/View/profile.dart';
import 'package:find_my_device/view/devices.dart';
import 'package:find_my_device/view/preferences.dart';
import 'package:flutter/material.dart';
import '../globals.dart' as globals;

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int currentPageIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  bool _isSearching = false;
  void _onSearchingButtonPressed() {
    setState(() {
      _isSearching = !_isSearching;
    });
  }

  @override
  Widget build(BuildContext context) {

    // List of widgets displayable via the bottom navigation bar
    final List<Widget> bottomNavOptions = <Widget>[
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 30),
            child: Image.asset(
              'assets/images/radar.png',
              height: 325,
              width: 325,
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
                    _onSearchingButtonPressed();
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
      const Devices(),
      const Profile(),
    ];

    final List<Widget> displaySearching = <Widget> [
      
    ];

    return Scaffold(
      resizeToAvoidBottomInset:
          false, //prevents resizing of widgets from keyboard popup
      backgroundColor: globals.colorDark,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: globals.colorHighlight,
        title: const Text("FindMyDevice"),
        centerTitle: true,
        titleTextStyle: globals.defaultFontHeader,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/preferences');
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),

      body: Center(
        child: bottomNavOptions.elementAt(currentPageIndex),
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: globals.colorLight,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.bluetooth_searching_rounded),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.devices_other),
            label: "Devices",
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
