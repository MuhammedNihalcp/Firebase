import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_user_firebase/app/module/login/controller/sign_controller.dart';
import 'package:flutter_user_firebase/app/module/login/view/register_page.dart';
import 'package:flutter_user_firebase/app/module/Home/view/home_page.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final authSignINController = Get.put(AuthService());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/login.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 35, top: 120),
              child: const Text(
                'Welcome\nBack',
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(left: 35, right: 35),
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.45),
                child: Form(
                    key: formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Fields(
                            icon: CupertinoIcons.mail,
                            isediting: true.obs,
                            hint: 'Email',
                            validator: 'Enter an Email',
                            cntrlr: emailController,
                            keybord: TextInputType.emailAddress),
                        Fields(
                            isediting: true.obs,
                            icon: CupertinoIcons.lock_circle,
                            length: 6,
                            hint: 'Password',
                            obscure: true,
                            validator: 'Enter your Password',
                            cntrlr: passwordController,
                            keybord: TextInputType.number),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Sign in',
                              style: TextStyle(
                                  fontSize: 27, fontWeight: FontWeight.w700),
                            ),
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: const Color(0xff4c505b),
                              child: IconButton(
                                color: Colors.white,
                                onPressed: () {
                                  if (formkey.currentState!.validate()) {
                                    authSignINController.signIn(
                                        emailController.text.trim(),
                                        passwordController.text.trim());
                                  }
                                },
                                icon: const Icon(
                                  Icons.arrow_forward,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(() => MyRegister());
                          },
                          style: const ButtonStyle(),
                          child: const Text(
                            'Create Account',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Color(0xff4c505b),
                                fontSize: 18),
                          ),
                        ),
                        SignInButton(
                          Buttons.GoogleDark,
                          onPressed: () {
                            // AuthController.instance.googleSignIn();
                          },
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
