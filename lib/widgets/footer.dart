import 'package:piggy_bank/utils/nav.dart';
import 'package:flutter/material.dart';
import '../constant.dart';
import '../utils/screen_size.dart';

class Footer extends StatefulWidget {
  final int btnIndex;
  const Footer({
    super.key,
    required this.btnIndex,
  });

  @override
  State<Footer> createState() => _FooterState();
}

String selectedBtn = 'Home';

class _FooterState extends State<Footer> {
  void setTap(String text) {
    setState(() {
      selectedBtn = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: ScreenSize().getScreenHeight(0.05),
          width: double.infinity,
          color: SECONDARY_COLOR,
        ),
        Container(
          height: ScreenSize().getScreenHeight(10),
          width: double.infinity,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenSize().getScreenWidth(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      setTap('Home');
                     AppNavigator.toHome(context);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          widget.btnIndex == 0
                              ? "assets/images/${ASSETS[9]}"
                              : "assets/images/${ASSETS[8]}",
                          width: ScreenSize().getScreenHeight(2.4),
                          height: ScreenSize().getScreenHeight(2.2),
                          fit: BoxFit.fill,
                        ),
                        SizedBox(
                          height: ScreenSize().getScreenHeight(0.5),
                        ),
                        Text(
                          "Home",
                          style: TextStyle(
                              fontSize: ScreenSize().getScreenHeight(1.5),
                              color: widget.btnIndex == 0
                                  ? SECONDARY_COLOR
                                  : Colors.black,
                              fontWeight: widget.btnIndex == 0
                                  ? FontWeight.w600
                                  : FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      setTap('Transactions');
                     AppNavigator.toHistory(context,true);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          widget.btnIndex == 1
                              ? "assets/images/${ASSETS[11]}"
                              : "assets/images/${ASSETS[7]}",
                          width: ScreenSize().getScreenHeight(2.5),
                          height: ScreenSize().getScreenHeight(2.2),
                          fit: BoxFit.fill,
                        ),
                        SizedBox(
                          height: ScreenSize().getScreenHeight(0.7),
                        ),
                        Text(
                          "Transactions",
                          style: TextStyle(
                              fontSize: ScreenSize().getScreenHeight(1.5),
                              color: widget.btnIndex == 1
                                  ? SECONDARY_COLOR
                                  : Colors.black,
                              fontWeight: widget.btnIndex == 1
                                  ? FontWeight.w600
                                  : FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      setTap('Settings');
                      AppNavigator.toSettingsScreen(context);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          widget.btnIndex == 2
                              ? "assets/images/${ASSETS[10]}"
                              : "assets/images/${ASSETS[6]}",
                          width: ScreenSize().getScreenHeight(2.4),
                          height: ScreenSize().getScreenHeight(2.2),
                          fit: BoxFit.fill,
                        ),
                        SizedBox(
                          height: ScreenSize().getScreenHeight(0.5),
                        ),
                        Text(
                          "Settings",
                          style: TextStyle(
                              fontSize: ScreenSize().getScreenHeight(1.5),
                              color: widget.btnIndex == 2
                                  ? SECONDARY_COLOR
                                  : Colors.black,
                              fontWeight: widget.btnIndex == 2
                                  ? FontWeight.w600
                                  : FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
