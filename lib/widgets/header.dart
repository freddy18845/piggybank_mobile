import 'package:piggy_bank/utils/fonts_style.dart';
import 'package:flutter/material.dart';
import '../constant.dart';
import '../utils/nav.dart';
import '../utils/screen_size.dart';


class Header extends StatefulWidget {
  final bool showHome;
  final bool showPrevious;
  final bool showLogo;
  final bool show2Nav;
  final String selectedBtn;

  //final Function previousFunction;

  const Header({
    super.key,
    required this.showHome,
    required this.showPrevious,
    required this.showLogo,
    required this.selectedBtn,
    required this.show2Nav,

    //required this.previousFunction,flutter.minSdkVersion
  });

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: ScreenSize().getScreenHeight(9),
          width: double.infinity,
          color: PRIMARY_COLOR,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: ScreenSize().getScreenWidth(6)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.showPrevious
                    ? InkWell(
                        onTap: () {
                         AppNavigator.toHome(context);
                        },
                        child: Container(
                          height: ScreenSize().getScreenHeight(5),
                          width: ScreenSize().getScreenHeight(5),
                          decoration: BoxDecoration(
                              color: SECONDARY_COLOR.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(
                                  ScreenSize().getScreenHeight(3.3))),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: ScreenSize().getScreenWidth(1)),
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: SECONDARY_COLOR,
                                size: ScreenSize().getScreenHeight(2.5),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(
                        width: ScreenSize().getScreenHeight(6),
                      ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: ScreenSize().getScreenHeight(0.8)),
                  child: Column(
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              width: 1,
                              color: SECONDARY_COLOR,
                            )),
                        child: Center(
                          child: Image.asset(
                            'assets/images/${IMAGES[5]}',
                            color: SECONDARY_COLOR,
                            height: 18,
                            width: 18,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            APP_NAME.toUpperCase(),
                            style: TextStyle(
                                fontSize: ScreenSize().getScreenHeight(1.5),
                                color: SECONDARY_COLOR,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                   // RouteMemory.clear();
                    AppNavigator.toLogin(context);
                  },
                  child: widget.showHome
                      ?  Container(
    height: ScreenSize().getScreenHeight(5),
    width: ScreenSize().getScreenHeight(5),
    decoration: BoxDecoration(
    color: SECONDARY_COLOR.withOpacity(0.2),
    borderRadius: BorderRadius.circular(
    ScreenSize().getScreenHeight(3.3))),
    child: Center(
    child: Padding(
    padding: EdgeInsets.only(
    left: ScreenSize().getScreenWidth(1)),
    child: Icon(
    Icons.logout_outlined,
    color: SECONDARY_COLOR,
    size: ScreenSize().getScreenHeight(2.5),
    ),
    ),
    ),
    )
                      : Container(
                          width: ScreenSize().getScreenHeight(6),
                        ),
                )
              ],
            ),
          ),
        ),
        widget.show2Nav
            ? Container(
                height: ScreenSize().getScreenHeight(3),
                width: double.infinity,
                color: SECONDARY_COLOR,
                child: Center(
                  child: Text(
                    widget.selectedBtn,
                    style: FontsStyle().headerTitle(),
                  ),
                ),
              )
            : Container(
                height: ScreenSize().getScreenHeight(0.05),
                width: double.infinity,
                color: SECONDARY_COLOR,
              )
      ],
    );
  }
}
