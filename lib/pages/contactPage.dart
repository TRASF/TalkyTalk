import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:projectmockpage/helper/HelperFunction.dart";
import "package:projectmockpage/service/auth_service.dart";
import "package:projectmockpage/service/database_service.dart";
import "package:projectmockpage/widget/nameTile.dart";

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  String userName = "";

  AuthService authService = AuthService();

  Stream? users;

  @override
  void initState() {
    super.initState();
    gettingUsername();
  }

  gettingUsername() async {
    await HelperFunctions.getUserName().then((value) {
      setState(() {
        userName = value!;
      });
    });

    await DatabaseService().getUser().then((snapshot) {
      setState(() {
        users = snapshot;
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
          "Contact",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 27),
        ),
      ),
      body: nameList(),
    );
  }

  nameList() {
    return StreamBuilder(
      stream: users,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final List filteredDocs = snapshot.data.docs
              .where((doc) =>
                  doc.get('uid') != FirebaseAuth.instance.currentUser!.uid)
              .toList();

          return ListView.builder(
            itemCount: filteredDocs.length,
            itemBuilder: (context, index) {
              return Nametile(
                  myName: userName,
                  friendName: filteredDocs[index].get('fullName'),
                  friendID: filteredDocs[index].get('uid'));
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          );
        }
      },
    );
  }
}
