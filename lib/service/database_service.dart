import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  //ref from collection
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference chatCollection =
      FirebaseFirestore.instance.collection("chats");

  //update user data
  Future updateUserData(String fullName, String email) async {
    return await userCollection.doc(uid).set({
      "fullName": fullName,
      "email": email,
      "chats": [],
      "profilePic": "",
      "uid": uid,
    });
  }

  Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }

  getUser() async {
    return userCollection.snapshots();
  }

  getUserchats() async {
    return userCollection.doc(uid).snapshots();
  }

  Future createChats(
      String myuserName, String friendName, String friendID) async {
    DocumentReference chatdocumentReference = await chatCollection.add({
      "chatName": friendName,
      "members": [myuserName, friendName],
      "chatID": "",
    });

    await chatdocumentReference.update({"chatID": chatdocumentReference.id});

    DocumentReference userDocumentReference = userCollection.doc(uid);
    userDocumentReference.update({
      "chats":
          FieldValue.arrayUnion(["${chatdocumentReference.id},$friendName"])
    });

    DocumentReference friendDocumentReference = userCollection.doc(friendID);
    friendDocumentReference.update({
      "chats":
          FieldValue.arrayUnion(["${chatdocumentReference.id},$myuserName"])
    });

    return chatdocumentReference.id;
  }

  Future<bool> isCreatedChat(String chatID) async {
    DocumentReference userDocumenRef = userCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await userDocumenRef.get();

    List<dynamic> chats = await documentSnapshot['chats'];
    if (chats.contains(chatID)) {
      return true;
    } else {
      return false;
    }
  }

  getChats(String chatID) async {
    return chatCollection
        .doc(chatID)
        .collection("messages")
        .orderBy("time")
        .snapshots();
  }

  sendMes(String chatID, Map<String, dynamic> chatmesdata) async {
    chatCollection.doc(chatID).collection("messages").add(chatmesdata);
  }
}
