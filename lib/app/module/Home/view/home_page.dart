// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/home_controller.dart';
import '../model/home_model.dart';
import '../../login/controller/sign_controller.dart';

class HomeSmple extends StatelessWidget {
  HomeSmple({super.key});
  RxBool isediting = false.obs;
  final AuthService authcontroller = Get.put(AuthService());
  final HomeController homeController = Get.put(HomeController());
  final TextEditingController nameController = TextEditingController();
  static GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController mobileControler = TextEditingController();
  final TextEditingController domainControler = TextEditingController();
  final CollectionReference user = FirebaseFirestore.instance
      .collection(FirebaseAuth.instance.currentUser!.email.toString());
  String id = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Obx(
            () {
              if (!isediting.value) {
                return IconButton(
                  onPressed: () {
                    authcontroller.signOut();
                  },
                  icon: const Icon(Icons.exit_to_app),
                );
              } else {
                return IconButton(
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        final String name =
                            nameController.text.trim().toUpperCase();
                        final String mob = mobileControler.text.trim();
                        final String age = ageController.text.trim();
                        final String domain =
                            domainControler.text.trim().toUpperCase();

                        final model = Details(
                            age: age,
                            domain: domain,
                            mob: mob,
                            name: name,
                            id: id);
                        await homeController.updateToDatabase(model);
                        isediting.value = !isediting.value;
                      }
                    },
                    icon: const Icon(Icons.check_circle_outline));
              }
            },
          )
        ],
      ),
      body: Form(
        key: formkey,
        child: StreamBuilder(
            stream: user.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.hasData) {
                final newList = streamSnapshot.data!.docs.map((e) {
                  return Details.fromJson(e.data() as Map<String, dynamic>);
                }).toList();
                nameController.text = newList.first.name.toString();
                ageController.text = newList.first.age.toString();
                domainControler.text = newList.first.domain.toString();
                mobileControler.text = newList.first.mob.toString();
                id = newList.first.id.toString();
                return ListView(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Center(
                      child: Text(
                        ' Your Details',
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Fields(
                        isediting: isediting,
                        cntrlr: nameController,
                        length: 15,
                        keybord: TextInputType.name,
                        hint: 'Name',
                        validator: 'Name is empty',
                        icon: CupertinoIcons.person),
                    Fields(
                        isediting: isediting,
                        cntrlr: mobileControler,
                        keybord: TextInputType.number,
                        length: 10,
                        hint: 'Mobile',
                        validator: 'Mobile is empty',
                        icon: CupertinoIcons.phone),
                    Fields(
                        isediting: isediting,
                        cntrlr: ageController,
                        keybord: TextInputType.number,
                        length: 2,
                        hint: 'Age',
                        validator: 'Age is empty',
                        icon: CupertinoIcons.circle_bottomthird_split),
                    Fields(
                        isediting: isediting,
                        keybord: TextInputType.text,
                        length: 10,
                        cntrlr: domainControler,
                        hint: 'Domain',
                        validator: 'Domain is empty',
                        icon: CupertinoIcons.infinite)
                  ],
                );
              } else {
                return const Center(
                    child: CupertinoActivityIndicator(
                  color: Colors.cyan,
                ));
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Edit',
        onPressed: () {
          isediting.value = !isediting.value;
        },
        child: const Icon(Icons.border_color_sharp),
      ),
    );
  }
}

class Fields extends StatelessWidget {
  const Fields({
    Key? key,
    required this.isediting,
    required this.cntrlr,
    required this.keybord,
    required this.hint,
    required this.validator,
    this.length,
    required this.icon,
    this.obscure,
  }) : super(key: key);

  final RxBool isediting;
  final TextEditingController? cntrlr;
  final TextInputType keybord;
  final String hint;
  final String validator;
  final int? length;
  final IconData icon;
  final bool? obscure;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          height: 75,
          child: TextFormField(
            maxLines: length,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return validator;
              } else {
                return null;
              }
            },
            controller: cntrlr,
            keyboardType: keybord,
            enabled: isediting.value,
            obscureText: obscure ?? false,
            autocorrect: true,
            maxLength: length,
            decoration: InputDecoration(
              icon: Icon(icon),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(color: Color.fromARGB(255, 26, 26, 26)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.black,
                ),
              ),
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
