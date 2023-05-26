import 'dart:developer';

import 'package:expense_tracker/custom_widget/custom_btn.dart';
import 'package:expense_tracker/custom_widget/custom_logo.dart';
import 'package:expense_tracker/custom_widget/custom_textfield.dart';
import 'package:expense_tracker/user_onboarding/login/login_screen.dart';
import 'package:flutter/material.dart';

import '../../ui_helper.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController mobNoController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  var hidePassword = true;

  var hideConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    var height = MediaQuery.of(context).size.height;
    var orientation = MediaQuery.of(context).orientation;
    print(orientation);
    return Scaffold(
        body: orientation == Orientation.portrait
            ? portraitUI(isLight, height)
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
              "Welcome",
              style: mTextStyle43(
                  mColor: isLight ? MyColor.bgBColor : MyColor.bgWColor),
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
                labelText: "Name",
                controller: nameController,
                icon: Icons.person,
                fillColor:
                    isLight ? MyColor.secondaryWColor : MyColor.secondaryBColor,
                obscureText: false),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
                labelText: "Email",
                controller: emailController,
                icon: Icons.email_outlined,
                fillColor:
                    isLight ? MyColor.secondaryWColor : MyColor.secondaryBColor,
                obscureText: false),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
                labelText: "Mobille No",
                controller: mobNoController,
                icon: Icons.call,
                fillColor:
                    isLight ? MyColor.secondaryWColor : MyColor.secondaryBColor,
                obscureText: false),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              labelText: "Password",
              controller: passwordController,
              icon: Icons.lock_outline,
              fillColor:
                  isLight ? MyColor.secondaryWColor : MyColor.secondaryBColor,
              obscureText: hidePassword,
              suffixIcon:
                  hidePassword ? Icons.visibility : Icons.visibility_off,
              voidCallback: () {
                hidePassword = !hidePassword;
                setState(() {});
              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
                labelText: "Confirm Password",
                controller: confirmPasswordController,
                icon: Icons.lock_outline,
                fillColor:
                    isLight ? MyColor.secondaryWColor : MyColor.secondaryBColor,
                obscureText: hideConfirmPassword,
                suffixIcon: hideConfirmPassword
                    ? Icons.visibility
                    : Icons.visibility_off,
                voidCallback: () {
                  hideConfirmPassword = !hideConfirmPassword;
                  setState(() {});
                }),
            SizedBox(
              height: 10,
            ),
            CustomBtn(
                text: "SignUp",
                voidCallback: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ));
                  // if (passwordController.text ==
                  //     confirmPasswordController.text) {
                  //   Navigator.pushReplacement(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => LoginScreen(),
                  //       ));
                  // } else {
                  //   log("Password and confirm pass does not match");
                  // }
                },
                color: isLight ? MyColor.bgBColor : MyColor.bgWColor,
                txtColor: isLight ? MyColor.bgWColor : MyColor.bgBColor),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text("Already have an account ?"),
                SizedBox(
                  width: 5,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ));
                    },
                    child: Text(
                      "Login",
                      style: mTextStyle16(mColor: Colors.blue),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget portraitUI(isLight, height) {
    return height > 600
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
