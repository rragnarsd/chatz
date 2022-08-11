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

  Future<DocumentSnapshot<Map<String, dynamic>>> getCurrentUser() {
    var userInfo = firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    return userInfo;
  }

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

  Future chat({required String userId, required String msg}) async {
    String myId = auth.currentUser!.uid;

    final newMessage = Message(
        message: msg,
        createdAt: DateTime.now(),
        sender: myId,
        receiver: userId,
        comp: [myId, userId]);
    await firestore.collection('chats').add(newMessage.toJson());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getChat(String uid) {
    return firestore
        .collection('chats')
        .where('comp', arrayContainsAny: [uid, auth.currentUser!.uid])
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
