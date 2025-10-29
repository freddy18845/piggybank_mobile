import 'dart:async';
import 'package:piggy_bank/constant.dart';
import 'package:piggy_bank/utils/fonts_style.dart';
import 'package:piggy_bank/utils/screen_size.dart';
import 'package:piggy_bank/view_models/store_view_model.dart';
import 'package:piggy_bank/widgets/inputFeild.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../dailog/password_reset.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool setupState = false;
  String message = "";

  @override
  void initState() {
    final storeViewModel = context.read<StoreViewModel>();

    WidgetsBinding.instance.addPostFrameCallback((_) {

      storeViewModel.getRememberMe();

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child:Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/images/${IMAGES[2]}',
                  ),
                  fit: BoxFit.fill)),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenSize().getScreenWidth(6)),
              child: Consumer<StoreViewModel>(
                builder: (context, store, child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: ScreenSize().getScreenHeight(18),
                      ),
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 2,
                            color: SECONDARY_COLOR,
                          ),
                        ),
                        child: Center(
                          child: Image.asset(
                            'assets/images/${IMAGES[5]}',
                            color: SECONDARY_COLOR,
                            height: 35,
                            width: 35,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Text(
                        APP_NAME.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 20,
                          color: SECONDARY_COLOR,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(
                        height: ScreenSize().getScreenHeight(2),
                      ),
                      InputFeild(
                        isOptional: false,
                        isNum: false,
                        icon: Icons.email_outlined,
                        inputLimit: 100,
                        placeholder: 'eg.johnDoe@gmail.com',
                        inputFeild: () {},
                        inputLabel: 'Email',
                        controller: store.controllers[
                            'email'], // Using provider's controller
                      ),
                      PasswordInputField(
                        icon: Icons.lock_clock_outlined,
                        placeholder: 'eg. ***',
                        inputLabel: 'Password',
                        controller: store.controllers[
                            'password'], onChanged: (String value) {  }, // Using provider's controller
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value:store.isRememberMeChecked,
                                activeColor: Colors.green,
                                onChanged: (bool? value) {
                                bool  isChecked = false;
                                  setState(() {
                                    isChecked = value!;
                                  });
                                  store.setRememberMeCheck(isChecked);
                                },
                              ),
                              Text(
                                "Remember Me",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return PasswordResetDialog(); // 👈 your dialog widget
                                },
                              );
                            },
                            child: Text(
                              "Forgot Password?  Reset",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: ScreenSize().getScreenHeight(1.5),
                      ),
                      InkWell(
                        onTap: () {
                          store.signIn(context);
                        },
                        child: Container(
                          height: 45,
                          padding: const EdgeInsets.symmetric(horizontal: 7),
                          decoration: BoxDecoration(
                            color: SECONDARY_COLOR,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: store.isProcessing
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    ),
                                  )
                                : const Text(
                                    'Login',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Copyright ${DateFormat.y().format(DateTime.now())} GoDigi Software Solutions. All Rights Reserved",
                        style: FontsStyle().footercopyRight(),
                      ),
                      SizedBox(
                        height: ScreenSize().getScreenHeight(7),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
        ) );
  }
}
