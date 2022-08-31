import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authentication {
  final FirebaseAuth auth = FirebaseAuth.instance;
  late final FirebaseFirestore firebaseFirestore;
  late final SharedPreferences prefs;
  registerUser(
      {required String name, required String email, required String password}) async {
    User? user;

    try {
      final UserCredential userCredential = await auth
          .createUserWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
      await user!.updateDisplayName(name);
      user = auth.currentUser;
      // ignore: empty_catches
    } catch (e) {
      log(e.toString().length);
    }

    return user;
  }

  loginUser({required String email, required String password}) async {
    User? user;
    try{
      final UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
      // ignore: empty_catches
    } catch (e) {}
    return user;
  }

}
