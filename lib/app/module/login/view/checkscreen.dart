import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_user_firebase/app/module/login/controller/sign_controller.dart';
import 'package:flutter_user_firebase/app/module/login/view/login_page.dart';
import 'package:flutter_user_firebase/app/module/Home/view/home_page.dart';
import 'package:get/get.dart';

class CheckScreen extends StatelessWidget {
   CheckScreen({super.key});
  final AuthService authcontroller = Get.put(AuthService());
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: authcontroller.stream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LoginPage();
          }else{
  return HomeSmple();
          }}
    );
  }
}