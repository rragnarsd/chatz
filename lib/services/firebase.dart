import 'package:chatz/data/models/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  String? uid;
  String? email;
  String? userName;
  String? userImg;

  Stream<QuerySnapshot<Map<String, dynamic>>> getUsers() {
    return firestore
        .collection('users')
        .orderBy('email', descending: true)
        .snapshots();
  }

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

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future updateName(String name) {
    var newName = firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .update({'name': name});
    return newName;
  }
}
