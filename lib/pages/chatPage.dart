import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projectmockpage/service/database_service.dart';
import 'package:projectmockpage/widget/messageTile.dart';

class ChatPage extends StatefulWidget {
  final String myName;
  final String chatid;
  final String chatname;

  const ChatPage(
      {Key? key,
      required this.myName,
      required this.chatid,
      required this.chatname})
      : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Stream<QuerySnapshot>? chats;
  TextEditingController messageC = TextEditingController();

  @override
  void initState() {
    getChat();
    super.initState();
  }

  getChat() {
    DatabaseService().getChats(widget.chatid).then((value) {
      setState(() {
        chats = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.chatname,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 27),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: chatMessage()),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                    child: TextFormField(
                  controller: messageC,
                  decoration: InputDecoration(
                    hintText: "Type your message...",
                    hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    fillColor: Colors.grey[200],
                    filled: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  ),
                )),
                const SizedBox(
                  width: 8,
                ),
                GestureDetector(
                  onTap: () {
                    sendMessage();
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  chatMessage() {
    return StreamBuilder(
      stream: chats,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return Messagetile(
                      message: snapshot.data.docs[index]['message'],
                      sender: snapshot.data.docs[index]['sender'],
                      meSend:
                          widget.myName == snapshot.data.docs[index]['sender']);
                },
              )
            : Container();
      },
    );
  }

  sendMessage() {
    if (messageC.text.isNotEmpty) {
      Map<String, dynamic> chatMessMap = {
        "message": messageC.text,
        "sender": widget.myName,
        "time": DateTime.now().millisecondsSinceEpoch,
      };

      DatabaseService().sendMes(widget.chatid, chatMessMap);
      setState(() {
        messageC.clear();
      });
    }
  }
}
