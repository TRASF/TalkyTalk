import 'package:flutter/material.dart';
import 'package:projectmockpage/helper/HelperFunction.dart';
import 'package:projectmockpage/pages/auth/loginPage.dart';
import 'package:projectmockpage/service/auth_service.dart';
import 'package:projectmockpage/widget/widgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userName = "";
  String email = "";
  AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() async {
    await HelperFunctions.getUserUserEmail().then((value) {
      setState(() {
        email = value!;
      });
    });

    await HelperFunctions.getUserName().then((value) {
      setState(() {
        userName = value!;
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
          "Profile",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 27),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 170),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Icon(
            Icons.account_circle,
            size: 200,
            color: Theme.of(context).primaryColor,
          ),
          SizedBox(height: 20),
          Text(
            userName,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            email,
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey[700],
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
              child: const Text(
                "Logout",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onPressed: () async {
                authService.signOut().whenComplete(() {
                  nextScreenReplace(context, LoginPage());
                });
              },
            ),
          ),
        ]),
      ),
    );
  }
}
