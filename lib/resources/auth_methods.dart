import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethodes {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Erro";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "Enter all the fields";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
