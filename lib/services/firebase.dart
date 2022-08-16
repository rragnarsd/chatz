import 'dart:developer';
import 'dart:io';

import 'package:chatz/constants/validations.dart';
import 'package:chatz/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FirebaseService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  String? uid;
  String? email;
  String? userName;
  String? userImg;

  //Auth

  Future loginUser(
      {required String email, required String password, context}) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(Validations().noUserWithEmail),
          ),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(Validations().wrongPassword),
        ));
      }
    }
  }

  Future registerUser(
      {required String userName,
      required String email,
      required String password,
      required String confirmPassword,
      required File profileImg,
      context}) async {
    if (password == confirmPassword) {
      try {
        await auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => FirebaseService()
                .saveUserInfoToFirestore(userName, email, profileImg));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          //TODO
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(Validations().weakPassword),
            ),
          );
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(Validations().accountExist),
            ),
          );
        }
      }
    } else {
      log('Passwords do not match');
    }
  }

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

  Stream<DocumentSnapshot<Map<String, dynamic>>>? getCurrentUserWithStream() {
    var userInfo =
        firestore.collection('users').doc(auth.currentUser!.uid).snapshots();
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

    var currentTime = DateTime.now();
    await firestore.collection('chats/$myId/messages').add({
      "conversation_id": userId,
      "user_id": myId,
      "message": msg,
      "createdAt": currentTime
    });
    await firestore.collection('chats/$userId/messages').add({
      "conversation_id": myId,
      "user_id": myId,
      "message": msg,
      "createdAt": currentTime
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getChat(String uid) {
    return firestore
        .collection('chats/${auth.currentUser!.uid}/messages')
        .where('conversation_id', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getChats(String uid) {
    return firestore
        .collection('chats/${auth.currentUser!.uid}/messages')
        .snapshots();
  }

  Future deleteChats(String messageId) async {
    try {
      await firestore
          .collection('chats')
          .doc(auth.currentUser!.uid)
          .collection('messages')
          .doc(messageId)
          .delete();
    } catch (e) {
      log(e.toString());
    }
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
