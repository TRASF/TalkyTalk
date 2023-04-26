import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:matcher/matcher.dart';
import 'package:projectmockpage/helper/HelperFunction.dart';
import 'package:projectmockpage/pages/chatPage.dart';
import 'package:projectmockpage/service/database_service.dart';
import 'package:projectmockpage/widget/widgets.dart';

class Nametile extends StatefulWidget {
  final String myName;
  final String friendName;
  final String friendID;
  const Nametile(
      {Key? key,
      required this.myName,
      required this.friendName,
      required this.friendID})
      : super(key: key);

  @override
  State<Nametile> createState() => _NametileState();
}

class _NametileState extends State<Nametile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Theme.of(context).primaryColor,
          child: Text(
            widget.friendName.substring(0, 1).toUpperCase(),
            textAlign: TextAlign.center,
          ),
        ),
        title: Text(
          widget.friendName,
        ),
        trailing: InkWell(
            onTap: () async {
              await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                  .createChats(
                      widget.myName, widget.friendName, widget.friendID);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).primaryColor,
                border: Border.all(color: Colors.white, width: 1),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: const Text(
                "Message",
                style: TextStyle(color: Colors.white),
              ),
            )),
      ),
    );
  }
}
