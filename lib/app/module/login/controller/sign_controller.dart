import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthService extends GetxController {
  final FirebaseAuth fb = FirebaseAuth.instance;

  Stream<User?> stream() => fb.authStateChanges();

  signUp(String email, String password) async {
    try {
      await fb.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (ex) {
      return Get.snackbar(
        'About User',
        'User Message',
        snackPosition: SnackPosition.BOTTOM,
        titleText: const Text('Account creation failed !'),
        messageText: Text(
          ex.toString(),
        ),
      );
    }
  }

  signIn(String email, String password) async {
    try {
      await fb.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      Get.snackbar(
        'About User',
        'User Message',
        snackPosition: SnackPosition.BOTTOM,
        titleText: const Text('Account creation failed !'),
        messageText: Text(
          e.toString(),
        ),
      );
    }
  }

  signOut() async {
    await fb.signOut();
    Get.snackbar(
      'About User',
      'User Message',
      snackPosition: SnackPosition.BOTTOM,
      titleText: const Text('Logout Successfully'),
    );
  }
}
