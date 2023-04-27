import 'package:flutter/material.dart';
import 'package:projectmockpage/pages/chatPage.dart';
import 'package:projectmockpage/widget/widgets.dart';

class ChatTile extends StatefulWidget {
  final String myName;
  final String chatID;
  final String chatName;
  const ChatTile({
    Key? key,
    required this.myName,
    required this.chatID,
    required this.chatName,
  }) : super(key: key);

  @override
  State<ChatTile> createState() => _ChatTileState();
}

class _ChatTileState extends State<ChatTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        nextScreen(
            context,
            ChatPage(
                myName: widget.myName,
                chatid: widget.chatID,
                chatname: widget.chatName));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Theme.of(context).primaryColor,
            child: Text(
              widget.chatName.substring(0, 1).toUpperCase(),
              textAlign: TextAlign.center,
            ),
          ),
          title: Text(widget.chatName),
        ),
      ),
    );
  }
}
