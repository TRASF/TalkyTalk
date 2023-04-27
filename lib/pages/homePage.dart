// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectmockpage/helper/HelperFunction.dart';
import 'package:projectmockpage/pages/contactPage.dart';
import 'package:projectmockpage/pages/profilePage.dart';
import 'package:projectmockpage/service/auth_service.dart';
import 'package:projectmockpage/service/database_service.dart';
import 'package:projectmockpage/widget/chatTile.dart';
import 'package:projectmockpage/widget/nameTile.dart';
import 'package:projectmockpage/widget/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = "";

  AuthService authService = AuthService();

  Stream? chats;

  @override
  void initState() {
    super.initState();
    getUsername();
  }

  getUsername() async {
    await HelperFunctions.getUserName().then((value) {
      setState(() {
        userName = value!;
      });
    });
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserchats()
        .then((snapshot) {
      setState(() {
        chats = snapshot;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
              onPressed: () {
                nextScreen(context, const ProfilePage());
              },
              icon: const Icon(Icons.account_circle)),
          IconButton(
              onPressed: () {
                nextScreen(context, const ContactPage());
              },
              icon: const Icon(Icons.contacts))
        ],
        centerTitle: true,
        title: const Text(
          "Chat",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 27),
        ),
      ),
      body: chatList(),
    );
  }

  chatList() {
    return StreamBuilder(
      stream: chats,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data['chats'].length,
            itemBuilder: (context, index) {
              return ChatTile(
                  myName: userName,
                  chatID: extractChatID(snapshot.data['chats'][index]),
                  chatName: extractChatName(snapshot.data['chats'][index]));
            },
          );
        } else {
          return Container();
        }
      },
    );
  }

  extractChatID(String chatarr) {
    return chatarr.substring(0, chatarr.indexOf(","));
  }

  extractChatName(String chatarr) {
    return chatarr.substring(chatarr.indexOf(",") + 1);
  }
}
