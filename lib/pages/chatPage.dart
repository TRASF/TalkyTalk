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
      body: Stack(
        children: <Widget>[
          chatMessage(),
          Container(
            alignment: Alignment.bottomCenter,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).primaryColor,
              child: Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    controller: messageC,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: "Message...",
                      hintStyle: TextStyle(fontSize: 16, color: Colors.white54),
                      border: InputBorder.none,
                    ),
                  )),
                  const SizedBox(
                    width: 12,
                  ),
                  GestureDetector(
                    onTap: () {
                      sendMessage();
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.black,
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
          )
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
