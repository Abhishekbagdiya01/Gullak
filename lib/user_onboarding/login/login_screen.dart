import 'package:expense_tracker/custom_widget/custom_btn.dart';
import 'package:expense_tracker/custom_widget/custom_logo.dart';
import 'package:expense_tracker/custom_widget/custom_textfield.dart';
import 'package:expense_tracker/screens/home_screen/home_screen.dart';
import 'package:expense_tracker/user_onboarding/signup/signup_screen.dart';
import 'package:flutter/material.dart';

import '../../ui_helper.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  var hidePassword = true;

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    var height = MediaQuery.of(context).size.height;
    var orientation = MediaQuery.of(context).orientation;

    return Scaffold(
        body: orientation == Orientation.portrait
            ? portraitUi(isLight, height)
            : landscapeUI(isLight));
  }

  Widget mainUi(isLight) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomLogo(
                mSize: 40,
                bgColor: isLight ? MyColor.bgBColor : MyColor.bgWColor,
                iconColor: isLight ? MyColor.bgWColor : MyColor.bgBColor),
            SizedBox(
              height: 21,
            ),
            Text(
              "Hello Again",
              style: mTextStyle43(
                mColor: isLight ? MyColor.bgBColor : MyColor.bgWColor,
              ),
            ),
            Text(
              "Welcome back you have been missed",
              style: mTextStyle16(mColor: MyColor.secondaryBColor),
            ),
            SizedBox(
              height: 28,
            ),
            CustomTextField(
              labelText: "Email",
              obscureText: false,
              controller: emailController,
              icon: Icons.mail_outlined,
              fillColor:
                  isLight ? MyColor.secondaryWColor : MyColor.secondaryBColor,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              labelText: "Password",
              obscureText: hidePassword,
              controller: passwordController,
              icon: Icons.lock_outline,
              suffixIcon:
                  hidePassword ? Icons.visibility : Icons.visibility_off,
              voidCallback: () {
                hidePassword = !hidePassword;
                setState(() {});
              },
              fillColor:
                  isLight ? MyColor.secondaryWColor : MyColor.secondaryBColor,
            ),
            SizedBox(
              height: 21,
            ),
            CustomBtn(
                text: "Login",
                voidCallback: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ));
                },
                txtColor: isLight ? MyColor.bgWColor : MyColor.bgBColor,
                color: isLight ? MyColor.bgBColor : MyColor.bgWColor),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text("Don't have an acount ?"),
                SizedBox(
                  width: 5,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpScreen(),
                          ));
                    },
                    child: Text("Sign-Up",
                        style: mTextStyle16(mColor: Colors.blue)))
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget portraitUi(isLight, height) {
    return height > 450
        ? mainUi(isLight)
        : SingleChildScrollView(
            child: mainUi(isLight),
          );
  }

  Widget landscapeUI(isLight) {
    return Row(
      children: [
        Expanded(
          child: Container(
            color: isLight ? MyColor.bgBColor : MyColor.bgWColor,
            child: Center(
              child: CustomLogo(
                  mSize: 80,
                  bgColor: isLight ? MyColor.bgWColor : MyColor.bgBColor,
                  iconColor: isLight ? MyColor.bgBColor : MyColor.bgWColor),
            ),
          ),
        ),
        Expanded(child: mainUi(isLight))
      ],
    );
  }
}
