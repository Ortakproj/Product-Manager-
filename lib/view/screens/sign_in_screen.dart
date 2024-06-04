//import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:product_manager/Controller/res/custom_colors.dart';
//import '../res/custom_colors.dart';
//import '../utils/authentication.dart';
import '../widgets/google_sign_in_button.dart';

class SignInScreen  extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.firebaseNavy,
      body: SafeArea(
        child: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background3.jpg"),
                fit: BoxFit.cover,
                // opacity: 0.4,
              ),
          ),
          // ignore: prefer_const_constructors
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child: const Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'hosgeldiniz',
                        style: TextStyle(

                          color: CustomColors.firebaseYellow,
                          fontSize: 40,
                        ),
                      ),
                    ],
                  ),
                ),
                GoogleSignInButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
