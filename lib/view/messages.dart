import 'package:find_my_device/View/profile.dart';
import 'package:find_my_device/controller/auth.dart';
import 'package:find_my_device/controller/mqtt_controller.dart';
import 'package:find_my_device/models/Mqtt_state.dart';
import 'package:find_my_device/view/contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../globals.dart' as globals;

// <------------------------------------------------------------------------------------>
class Messages extends StatefulWidget {
  const Messages({super.key});

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  final uuidGen = const Uuid();

  final _messageController = TextEditingController();
  final _topicController = TextEditingController(text: "flutter/app/test");
  late AppState currentAppState;
  late MqttController controller;

  bool _visible = true;

  int currentPageIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AppState appState = Provider.of<AppState>(context);
    // Keep a reference to the app state.
    currentAppState = appState;

    // List of widgets displayable via the bottom navigation bar
    final List<Widget> bottomNavOptions = <Widget>[
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildConnectionState(),
          Container(
            margin: const EdgeInsets.all(2.0),
            child: TextFormField(
              textInputAction: TextInputAction.next,
              controller: _topicController,
              decoration: InputDecoration(
                border: const UnderlineInputBorder(),
                labelText: 'Topic',
                labelStyle: globals.defaultFontText,
                prefixIcon: const Icon(Icons.person),
                fillColor: globals.colorLight,
                filled: true,
              ),
            ),
          ),
          SingleChildScrollView(
            // TODO print all messages!
            // child: Text(currentAppState.getHistoryText())
            child: Column(
              children: [
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: appState.getHistoryText().length,
                    itemBuilder: ((context, index) {
                      return ListTile(
                          title: Row(
                        children: <Widget>[
                          Text(appState.getHistoryText().elementAt(index))
                        ],
                      ));
                    }))
              ],
            ),
          ),
          // Container(
          //   margin: const EdgeInsets.all(2.0),
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: TextFormField(
          //           textInputAction: TextInputAction.next,
          //           controller: _messageController,
          //           decoration: InputDecoration(
          //               border: const UnderlineInputBorder(),
          //               labelText: 'Message',
          //               labelStyle: globals.defaultFontText,
          //               prefixIcon: const Icon(Icons.person),
          //               fillColor: globals.colorLight,
          //               filled: true),
          //         ),
          //       ),
          //       _buildSendButton(),
          //     ],
          //   ),
          // ),

          // Row(
          //   children: [
          //     // Connect Button
          //     Expanded(
          //         child: ElevatedButton(
          //       style: ButtonStyle(
          //         padding: MaterialStateProperty.all<EdgeInsets>(
          //             const EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
          //         backgroundColor:
          //             currentAppState.getState().name == "connected"
          //                 ? MaterialStateProperty.all(Colors.grey)
          //                 : MaterialStateProperty.all(globals.colorHighlight),
          //       ),
          //       child: const Text("Connect"),
          //       onPressed: () {
          //         currentAppState.getState().name == "connected"
          //             ? null
          //             : _doConnect();
          //       },
          //     )),
          //     // Disconnect Button
          //     Expanded(
          //         child: ElevatedButton(
          //       style: ButtonStyle(
          //         padding: MaterialStateProperty.all<EdgeInsets>(
          //             const EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
          //         backgroundColor:
          //             currentAppState.getState().name == "connected"
          //                 ? MaterialStateProperty.all(globals.colorHighlight)
          //                 : MaterialStateProperty.all(Colors.grey),
          //       ),
          //       child: const Text("Disconnect"),
          //       onPressed: () {
          //         currentAppState.getState().name == "connected"
          //             ? _doDisconnect()
          //             : null;
          //       },
          //     )),
          //   ],
          // ),
        ],
      ),
      const Contacts(),
      const Profile(),
    ];

    return Scaffold(
      persistentFooterButtons: [
        Container(
          margin: const EdgeInsets.all(2.0),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: _messageController,
                  decoration: InputDecoration(
                      border: const UnderlineInputBorder(),
                      labelText: 'Message',
                      labelStyle: globals.defaultFontText,
                      prefixIcon: const Icon(Icons.person),
                      fillColor: globals.colorLight,
                      filled: true),
                ),
              ),
              _buildSendButton(),
            ],
          ),
        ),
      ],
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

  // Display the current state of connection for the app
  Widget _buildConnectionState() {
    if (currentAppState.getState() == AppConnectionState.disconnected) {
      return Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        width: MediaQuery.of(context).size.width,
        color: Colors.redAccent,
        child: Text(
          "Currently Disconnected",
          textAlign: TextAlign.center,
          style: globals.defaultFontHeader,
        ),
      );
    }

    if (currentAppState.getState() == AppConnectionState.connecting) {
      return Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        width: MediaQuery.of(context).size.width,
        color: Colors.yellowAccent,
        child: Text(
          "Connecting...",
          textAlign: TextAlign.center,
          style: globals.defaultFontHeader,
        ),
      );
    }

    // Hide the Connected widget after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _visible = false;
      });
    });

    if (_visible) {
      return Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        width: MediaQuery.of(context).size.width,
        color: Colors.greenAccent,
        child: Text(
          "Connected!",
          textAlign: TextAlign.center,
          style: globals.defaultFontHeader,
        ),
      );
    }
    return Container();
  }

  Widget _buildSendButton() {
    return ElevatedButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(
            const EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
        backgroundColor: currentAppState.getState().name == "connected"
            ? MaterialStateProperty.all(globals.colorHighlight)
            : MaterialStateProperty.all(Colors.grey),
      ),
      onPressed: () {
        currentAppState.getState().name == "connected"
            ? _doPublishMessage()
            : null;
      },
      child: const Icon(
        Icons.send,
        size: 40,
      ),
    );
  }

  void _doConnect() {
    final uuid = uuidGen.v4();
    controller = MqttController(
      state: currentAppState,
      id: uuid,
      topic: _topicController.text,
    );
    controller.initialiseClient();
    controller.connect();
  }

  void _doDisconnect() {
    controller.disconnect();
  }

  void _doPublishMessage() {
    final userName = Auth().user!.email;
    controller.publish("${userName!}: ${_messageController.text}");
    _messageController.clear();
  }
}
