import 'dart:async';

import 'package:expense_tracker/custom_widget/custom_logo.dart';

import 'package:expense_tracker/ui_helper.dart';

import 'package:expense_tracker/user_onboarding/signup/signup_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SignUpScreen(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    var mSize = MediaQuery.of(context).size.width;
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          CustomLogo(
              mSize: 80,
              bgColor: isLight ? MyColor.bgBColor : MyColor.bgWColor,
              iconColor: isLight ? MyColor.bgWColor : MyColor.bgBColor),
          SizedBox(
            height: 10,
          ),
          Text(
            "Expenses Tracker",
            style: isLight
                ? mTextStyle43(mColor: MyColor.bgBColor)
                : mTextStyle43(mColor: MyColor.bgWColor),
          )
        ]),
      ),
    );
  }
}
