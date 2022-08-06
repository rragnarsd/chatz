import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future getUserData() async {
    var email = auth.currentUser!.email;
    dynamic userData;

    try {
      final result = await firestore.collection('users').get();
      final data =
          result.docs.where((element) => element['email'] == email).first;
      userData = data;
    } catch (e) {
      log(e.toString());
    }
    return userData;
  }
  
}
