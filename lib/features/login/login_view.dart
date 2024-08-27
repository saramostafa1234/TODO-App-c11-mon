import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_c11_mon/core/applicition_theme_manager.dart';
import 'package:todo_app_c11_mon/core/page_route_names.dart';

import '../../core/firebase_utlis.dart';
import '../../core/widget/setting_prov.dart';

class LoginView extends StatefulWidget {
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isObscured = true;
  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context);
    var provider = Provider.of<SettingsProvider>(context);
    return Container(
      decoration: BoxDecoration(
          color: theme.primaryColor,
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: const Text(
            "Login",
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: mediaQuery.size.height * 0.2),
                  Text(
                    "Welcome back!",
                    textAlign: TextAlign.start,
                    style: theme.textTheme.bodyLarge?.copyWith(
                        color: provider.isDark() ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: emailController,
                    cursorColor: ApplicitionThemeManager.primaryBlueColor,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      //color: Colors.black,
                      color: provider.isDark() ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "pleaze enter your emil";
                      }
                      var regex = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                      if (!regex.hasMatch(value)) {
                        return "invailid email";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      label: Text("E-mail",
                          style: theme.textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                            // color:provider.isDark()?Colors.white:Colors.black,

                            fontSize: 25,
                          )),
                      hintText: "Enter your email address",
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: theme.primaryColorLight,
                          width: 2,
                        ),
                      ),
                      enabledBorder: const UnderlineInputBorder(),
                      //prefixIcon: Icon(Icons.email),
                      suffixIcon: Icon(Icons.email),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: passwordController,
                    cursorColor: ApplicitionThemeManager.primaryBlueColor,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      //color: Colors.black,
                      color: provider.isDark() ? Colors.white : Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    obscureText: isObscured,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "pleaze enter your password";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      label: Text("PassWord",
                          style: theme.textTheme.displayLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          )),
                      hintText: "Enter your Password",
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: theme.primaryColor,
                          width: 2,
                        ),
                      ),
                      enabledBorder: const UnderlineInputBorder(),
                      //prefixIcon: Icon(Icons.email),
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            isObscured = !isObscured;
                          });
                        },
                        child: Icon(isObscured
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      "Forget PassWord",
                      style: theme.textTheme.displaySmall
                          ?.copyWith(decoration: TextDecoration.underline),
                    ),
                  ),
                  SizedBox(height: 60),
                  FilledButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        PageRouteName.layout,
                      );
                      if (formKey.currentState!.validate()) {
                        FirebaseUtils.signIn(
                                emailController.text, passwordController.text)
                            .then((value) {
                          if (value) {
                            EasyLoading.dismiss();

                            Navigator.pushReplacementNamed(
                                context, PageRouteName.layout);
                          }
                        });
                      }
                    },
                    style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 12),
                        backgroundColor: theme.primaryColorLight,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "login",
                          style: theme.textTheme.displayMedium?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        PageRouteName.registration,
                      );
                    },
                    child: Text(
                      "Or Create My Account",
                      style: theme.textTheme.displaySmall
                          ?.copyWith(decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
