import 'package:chatz/data/models/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  String userName = '';
  String userImg = '';

  Future getCurrentUser() async {
    DocumentSnapshot snapshot =
        await firestore.doc(auth.currentUser!.uid).get();
    String name = snapshot.get('name');
    name = userName;
    String imgUrl = snapshot.get('imgUrl');
    imgUrl = userImg;
    String lastMessage = snapshot.get('lastMessage');
    return [
      name,
      imgUrl,
      lastMessage,
    ];
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getUsers() {
    return firestore
        .collection('users')
        .orderBy('email', descending: true)
        .snapshots();
  }

  Future createChat(String idUser, String message) async {
    final docs = firestore.collection('chats/$idUser/messages');

    final newMessage = Message(
      message: message,
      createdAt: DateTime.now(),
      uid: auth.currentUser!.uid,
      imgUrl: userImg,
      name: userName,
    );
    await docs.add(newMessage.toJson());

    final refUsers = firestore.collection('users');
    await refUsers.doc(idUser).update({'lastMessage': DateTime.now()});
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getChat(String idUser) {
    return firestore
        .collection('chats/$idUser/messages')
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
