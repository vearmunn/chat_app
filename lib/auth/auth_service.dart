import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signIn(String email, String password, context) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Error'),
                content: Text(e.message!),
              ));
    }
  }

  Future signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw e.code;
    }
  }
}
