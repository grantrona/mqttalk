import 'package:find_my_device/View/profile.dart';
import 'package:find_my_device/view/contacts.dart';
import 'package:flutter/material.dart';
import '../globals.dart' as globals;

class Messages extends StatefulWidget {
  const Messages({super.key});

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
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
    final List<Widget> displaySearchOptions = <Widget>[
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
                    Icons.add,
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
                    'New Message',
                    style: globals.defaultFontTitleBold,
                  )),
            ),
          )
        ],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              margin: const EdgeInsets.only(top: 30),
              child: const Icon(
                Icons.radar,
                size: 325,
              )),
          Container(
            margin: const EdgeInsets.only(top: 40),
            child: FractionallySizedBox(
              widthFactor: 0.8,
              child: ElevatedButton.icon(
                  icon: const Icon(
                    Icons.cancel_outlined,
                    size: 35,
                  ),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.all(20)),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.amber.shade800),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ))),
                  onPressed: () {
                    _onSearchingButtonPressed();
                    // TODO
                  },
                  label: Text(
                    'Stop Searching',
                    style: globals.defaultFontTitleBold,
                  )),
            ),
          )
        ],
      ),
    ];

    // List of widgets displayable via the bottom navigation bar
    final List<Widget> bottomNavOptions = <Widget>[
      _isSearching
          ? displaySearchOptions.elementAt(1)
          : displaySearchOptions.elementAt(0),
      const Contacts(),
      const Profile(),
    ];

    return Scaffold(
      resizeToAvoidBottomInset:
          false, //prevents resizing of widgets from keyboard popup
      backgroundColor: globals.colorDark,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: globals.colorHighlight,
        title: const Text("Chatterbox"),
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
            icon: Icon(Icons.message_rounded),
            label: "Message",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            label: "Contacts",
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
