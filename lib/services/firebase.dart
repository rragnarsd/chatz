import 'dart:developer';
import 'dart:io';

import 'package:chatz/data/models/chat_model.dart';
import 'package:chatz/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  String? uid;
  String? email;
  String? userName;
  String? userImg;

  //Auth

  void saveUserInfoToFirestore(
      String userName, String email, File profileImg) async {
    User? user = auth.currentUser;

    String? imageURL = await FirebaseService().uploadImageToStorage(profileImg);

    UserModel model = UserModel(
      uid: auth.currentUser!.uid,
      name: userName,
      email: email,
      imgUrl: imageURL,
    );

    await firestore.collection('users').doc(user!.uid).set(model.toJson());
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  //Users

  Stream<QuerySnapshot<Map<String, dynamic>>> getUsers() {
    var users = firestore
        .collection('users')
        .where('uid', isNotEqualTo: auth.currentUser!.uid)
        .snapshots();
    return users;
  }

  Future<QuerySnapshot<Object?>> searchUsers(String userName) async {
    return firestore
        .collection('users')
        .where('name', isEqualTo: userName)
        .get();
  }

  //Chats

  Future createChat(String uid, String message) async {
    final docs = firestore.collection('chats/$uid/messages');
    User? user = auth.currentUser;
    uid = user!.uid;
    email = user.email;

    final DocumentSnapshot userDoc =
        await firestore.collection('users').doc(uid).get();
    userName = userDoc.get('name');
    userImg = userDoc.get('imgUrl');

    final newMessage = Message(
      message: message,
      createdAt: DateTime.now(),
      uid: uid,
      imgUrl: userImg ?? '',
      name: userName ?? '',
    );
    await docs.add(newMessage.toJson());

    final docUsers = firestore.collection('users');
    await docUsers.doc(uid).update({'lastMessage': DateTime.now()});
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getChat(String uid) {
    return firestore
        .collection('chats/$uid/messages')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  //Update - Upload

  Future updateName(String name) {
    var newName = firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .update({'name': name});
    return newName;
  }

  Future updateImg(String imgUrl) {
    var newImg = firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .update({'imgUrl': imgUrl});

    return newImg;
  }

  Future<String?> uploadImageToStorage(File imgUrl) async {
    try {
      Reference reference =
          storage.ref().child('images').child(auth.currentUser!.uid);
      UploadTask task = reference.putFile(imgUrl);
      TaskSnapshot snap = await task;
      String imageUrl = await snap.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
