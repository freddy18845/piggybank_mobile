import 'dart:async';
import 'package:piggy_bank/constant.dart';
import 'package:piggy_bank/utils/utils.dart';
import 'package:piggy_bank/views/login_screen.dart';
import 'package:flutter/material.dart';

import '../utils/nav.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool setupState = false;
  String message = "";

  Future<dynamic> setupSDKS(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 2000));

    AppNavigator.toLogin(context);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setupSDKS(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 2,
                            color: SECONDARY_COLOR,
                          )),
                      child: Center(
                        child: Image.asset(
                          'assets/images/${IMAGES[5]}',
                          color: SECONDARY_COLOR,
                          height: 50,
                          width: 50,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Text(
                      APP_NAME.toUpperCase(),
                      style: const TextStyle(
                          fontSize: 25,
                          color: SECONDARY_COLOR,
                          fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    setupState
                        ? const SizedBox()
                        : SizedBox(
                            height: 40,
                            width: 40,
                            child: CircularProgressIndicator(
                              color: SECONDARY_COLOR.withOpacity(0.8),
                            )),
                    const SizedBox(
                      height: 10,
                    ),
                    !setupState
                        ? const SizedBox()
                        : Align(
                            alignment: Alignment.center,
                            child: Text(
                              message,
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.black),
                            ),
                          ),
                    const SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
