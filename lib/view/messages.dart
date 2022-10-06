import 'package:find_my_device/View/profile.dart';
import 'package:find_my_device/controller/auth.dart';
import 'package:find_my_device/controller/mqtt_controller.dart';
import 'package:find_my_device/models/Mqtt_state.dart';
import 'package:find_my_device/models/topics.dart';
import 'package:find_my_device/view/contacts.dart';
import 'package:flutter/material.dart';
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
  late AppState currentAppState;
  late MqttController controller;

  final _topics = Topics().getTopics();
  String? _selectedTopic;

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
        children: [
          Expanded(
            flex: 1,
            child: Stack(
              children: [
                _buildConnectionState(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                  child: DropdownButtonFormField(
                      isExpanded: true,
                      decoration: InputDecoration(
                          fillColor: globals.colorLight,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 3, color: globals.colorHighlight))),
                      hint: const Text("Select a Topic"),
                      items: _topics
                          .map((item) => DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              ))
                          .toList(),
                      value: _selectedTopic,
                      onChanged: ((newValue) {
                        setState(() {
                          _selectedTopic = newValue;
                        });
                        if (currentAppState.getState().name == "connected") {
                          _doDisconnect();
                        }
                        _doConnect();
                      })),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: _messageController,
                    decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        labelText: 'Message...',
                        labelStyle: globals.defaultFontText,
                        prefixIcon: const Icon(Icons.chat_bubble_outline),
                        fillColor: globals.colorLight,
                        filled: true),
                  ),
                ),
                _buildSendButton(),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: SingleChildScrollView(
              child: Column(
                children: _buildTextWidgets(),
              ),
            ),
          ),

          // TODO return to this is above does not work!
          // Expanded(
          //     flex: 5,
          //     child: Container(
          //       alignment: Alignment.topLeft,
          //       child: ConstrainedBox(
          //         constraints: BoxConstraints(
          //           maxWidth: MediaQuery.of(context).size.width * 2 / 3,
          //         ),
          //         child: ListView.builder(
          //             physics: const AlwaysScrollableScrollPhysics(),
          //             shrinkWrap: true,
          //             itemCount: currentAppState.getHistoryText().length,
          //             itemBuilder: ((context, index) {
          //               return ListTile(
          //                   tileColor: Colors.blueAccent,
          //                   title: Row(
          //                     children: <Widget>[
          //                       currentAppState
          //                               .getHistoryText()
          //                               .elementAt(index)
          //                               .sentExternally()
          //                           ? Flexible(

          //                               child: Align(
          //                                 alignment: Alignment.centerRight,
          //                                 child: Text(
          //                                   currentAppState
          //                                       .getHistoryText()
          //                                       .elementAt(index)
          //                                       .getMessage(),
          //                                   style: const TextStyle(
          //                                       color: Colors.red),
          //                                   textAlign: TextAlign.right,
          //                                   textWidthBasis:
          //                                       TextWidthBasis.longestLine,
          //                                 ),
          //                               ),
          //                             )
          //                           : Flexible(
          //                               child: Align(
          //                                 alignment: Alignment.centerLeft,
          //                                 child: Text(
          //                                   currentAppState
          //                                       .getHistoryText()
          //                                       .elementAt(index)
          //                                       .getMessage(),
          //                                   style: const TextStyle(
          //                                       color: Colors.white),
          //                                   textAlign: TextAlign.right,
          //                                   textWidthBasis:
          //                                       TextWidthBasis.longestLine,
          //                                 ),
          //                               ),
          //                             )
          //                       // Text(currentAppState
          //                       //     .getHistoryText()
          //                       //     .elementAt(index))
          //                     ],
          //                   ));
          //             })),
          //       ),
          //     ))
        ],
      ),
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

  // Individual text widgets for each text stored in mqtt_state
  _buildTextWidgets() {
    List<Widget> textsWidgets = [];
    currentAppState.getHistoryText().forEach((message) {
      //  Messages sent externally
      if (message.sentExternally()) {
        textsWidgets.add(Align(
          alignment: Alignment.topLeft,
          child: ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * (2 / 3)),
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.fromLTRB(5, 0, 0, 10),
              decoration: BoxDecoration(
                color: globals.colorLight,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                message.getMessage(),
                style: globals.defaultFontText,
                textWidthBasis: TextWidthBasis.parent,
              ),
            ),
          ),
        ));
      } else {
        //  Messages from users own device
        textsWidgets.add(
          Align(
            alignment: Alignment.topRight,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * (2/3)),
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.fromLTRB(0, 0, 5, 10),
                decoration: BoxDecoration(
                  color: globals.colorHighlight,
                  borderRadius: BorderRadius.circular(15), 
                  ),
                child: Text(
                message.getMessage(),
                style: globals.defaultFontText,
                textWidthBasis: TextWidthBasis.parent,
                ),
              ),
            ),
          ));
      }
    });
    return textsWidgets;
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
      // topic: _topicController.text,
      topic: "flutter/app/$_selectedTopic",
    );
    Auth().setHistory(currentAppState, "flutter/app/$_selectedTopic");
    controller.initialiseClient();
    controller.connect();
  }

  void _doDisconnect() {
    _visible = true;
    controller.disconnect();
  }

  void _doPublishMessage() {
    final userName = Auth().user!.email;
    controller.publish("${userName!}: ${_messageController.text}");
    _messageController.clear();
  }
}
