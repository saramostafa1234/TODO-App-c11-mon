import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_c11_mon/core/firebase_utlis.dart';
import 'package:todo_app_c11_mon/core/services/snack_bar_service.dart';

import '../../core/widget/setting_prov.dart';

class RegistrationView extends StatefulWidget {
  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  bool isObscured = true;
  var formKey = GlobalKey<FormState>();
  TextEditingController userController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context);
    var provider = Provider.of<SettingsProvider>(context);
    return Container(
      decoration: BoxDecoration(
          color: provider.isDark() ? theme.primaryColor : Color(0xFFDFECDB),
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
            "Create Account",
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
                  TextFormField(
                    controller: userController,
                    cursorColor: theme.primaryColor,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: provider.isDark() ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "plz enter your full name";
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      label: Text("Full Name",
                          style: theme.textTheme.displayLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                            color:
                                provider.isDark() ? Colors.white : Colors.black,
                            fontSize: 20,
                          )),
                      hintText: "Enter your full name",
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: theme.primaryColor,
                          width: 2,
                        ),
                      ),
                      enabledBorder: const UnderlineInputBorder(),
                      //prefixIcon: Icon(Icons.email),
                      suffixIcon: Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: emailController,
                    cursorColor: theme.primaryColor,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: provider.isDark() ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w500,
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
                          style: theme.textTheme.displayLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                            color:
                                provider.isDark() ? Colors.white : Colors.black,
                            fontSize: 25,
                          )),
                      hintText: "Enter your email address",
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: theme.primaryColor,
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
                    cursorColor: theme.primaryColor,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: provider.isDark() ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    obscureText: isObscured,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "pleaze enter your password";
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      label: Text("PassWord",
                          style: theme.textTheme.displayLarge?.copyWith(
                            color:
                                provider.isDark() ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 25,
                          )),

                      hintText: "Enter your Password",
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
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
                  SizedBox(height: 60),
                  FilledButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        FirebaseUtils.createAccount(
                                emailController.text, passwordController.text)
                            .then((value) {
                          if (value) {
                            EasyLoading.dismiss();
                            SnackBarService.showSuccessMessage(
                                "Account created successfully");
                            Navigator.pop(context);
                          }
                        });
                      }
                    },
                    style: FilledButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                        backgroundColor: Color(0xFF5D9CEC),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Create Account",
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
