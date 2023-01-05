import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_user_firebase/app/module/Home/controller/home_controller.dart';
import 'package:flutter_user_firebase/app/module/login/controller/sign_controller.dart';
import 'package:flutter_user_firebase/app/module/login/view/login_page.dart';
import 'package:flutter_user_firebase/app/module/Home/view/home_page.dart';
import 'package:get/get.dart';

import '../../Home/model/home_model.dart';

class MyRegister extends StatelessWidget {
  MyRegister({Key? key}) : super(key: key);
  final TextEditingController domainController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  static GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController mobileControler = TextEditingController();
  final AuthService authController = Get.put(AuthService());
  final HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/register.png'), fit: BoxFit.cover),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              'Create Account',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 35),
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        Fields(
                            icon: CupertinoIcons.mail,
                            validator: 'Enter an Email',
                            isediting: true.obs,
                            hint: 'Email',
                            cntrlr: emailController,
                            keybord: TextInputType.emailAddress),
                        Fields(
                          icon: CupertinoIcons.lock_circle,
                          length: 6,
                          validator: 'Enter a Password',
                          hint: 'Password',
                          cntrlr: passwordController,
                          keybord: TextInputType.visiblePassword,
                          isediting: true.obs,
                        ),
                        Fields(
                            isediting: true.obs,
                            keybord: TextInputType.name,
                            cntrlr: nameController,
                            hint: 'Name',
                            length: 15,
                            validator: 'Name is empty',
                            icon: CupertinoIcons.person),
                        Fields(
                            isediting: true.obs,
                            keybord: TextInputType.number,
                            cntrlr: ageController,
                            hint: 'Age',
                            length: 2,
                            validator: 'Age is empty',
                            icon: CupertinoIcons.number_circle),
                        Fields(
                            isediting: true.obs,
                            keybord: TextInputType.number,
                            cntrlr: mobileControler,
                            length: 10,
                            hint: 'Mobile',
                            validator: 'Mobile is empty',
                            icon: CupertinoIcons.phone_circle),
                        Fields(
                            isediting: true.obs,
                            keybord: TextInputType.name,
                            cntrlr: domainController,
                            length: 15,
                            hint: 'Domain',
                            validator: 'Domain is empty',
                            icon: CupertinoIcons.infinite),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Sign Up',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 27,
                                  fontWeight: FontWeight.w700),
                            ),
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: const Color(0xff4c505b),
                              child: IconButton(
                                color: Colors.white,
                                onPressed: () async {
                                  if (formkey.currentState!.validate()) {
                                    await authController.signUp(
                                        emailController.text.trim(),
                                        passwordController.text.trim());

                                    final String name = nameController.text
                                        .trim()
                                        .toUpperCase();
                                    final String mob =
                                        mobileControler.text.trim();
                                    final String age =
                                        ageController.text.trim();
                                    final String domain = domainController.text
                                        .trim()
                                        .toUpperCase();

                                    final model = Details(
                                        age: age,
                                        domain: domain,
                                        mob: mob,
                                        name: name,
                                        id: 'temp');
                                    await homeController.addToDatabase(model);
                                    
                                  }
                                },
                                icon: const Icon(
                                  Icons.arrow_forward,
                                ),
                              ),
                            )
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(() => LoginPage());
                          },
                          style: const ButtonStyle(),
                          child: const Text(
                            'Log In',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Color.fromARGB(255, 20, 19, 19),
                                fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
