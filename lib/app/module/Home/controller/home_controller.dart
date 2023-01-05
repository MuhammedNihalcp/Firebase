import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_user_firebase/app/module/Home/model/home_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  addToDatabase(Details model) async {
    final CollectionReference users = FirebaseFirestore.instance
        .collection(FirebaseAuth.instance.currentUser!.email.toString());
    final generatedID = await users.add(model.toJson());
    model.id = generatedID.id;
    await users.doc(generatedID.id).update(model.toJson());
    Get.back();
  }

  updateToDatabase(Details model) async {
    final CollectionReference users = FirebaseFirestore.instance
        .collection(FirebaseAuth.instance.currentUser!.email.toString());
    final id = model.id;
    await users.doc(id).update(model.toJson());
  }
}
