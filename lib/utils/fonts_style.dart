
import 'package:flutter/material.dart';
import 'package:piggy_bank/utils/screen_size.dart';

import '../constant.dart';

// ignore: unused_import

class FontsStyle {
  headerSubTitle() {
    return TextStyle(
        fontSize: ScreenSize().getScreenHeight(1.6),
        color: Colors.black,
        fontWeight: FontWeight.w600);
  }

  subTitle() {
    return TextStyle(
        fontSize: ScreenSize().getScreenHeight(1.8),
        color: SECONDARY_COLOR,
        fontWeight: FontWeight.w400);
  }

  subTitleTwo() {
    return TextStyle(
        decoration: TextDecoration.none,
        fontSize: ScreenSize().getScreenHeight(1.4),
        fontWeight: FontWeight.w600,
        color: Colors.black);
  }

  depositTitle() {
    return TextStyle(
        decoration: TextDecoration.none,
        fontSize: ScreenSize().getScreenHeight(1.4),
        fontWeight: FontWeight.w500,
        color: Colors.black);
  }

  recieptTitle() {
    return TextStyle(
        fontSize: ScreenSize().getScreenHeight(1.3),
        color: Colors.black,
        fontWeight: FontWeight.w600);
  }

  recieptText() {
    return TextStyle(
        fontSize: ScreenSize().getScreenHeight(1.4),
        color: GRAY_COLOR.withOpacity(0.8),
        fontWeight: FontWeight.w400);
  }

  newCustomerTitle() {
    return TextStyle(
        fontSize: ScreenSize().getScreenHeight(1.4),
        color: Colors.black,
        fontWeight: FontWeight.w600);
  }

  newCustomerText() {
    return TextStyle(
        fontSize: ScreenSize().getScreenHeight(1.6),
        color: GRAY_COLOR.withOpacity(0.8),
        fontWeight: FontWeight.w400);
  }

  tabletitle() {
    return TextStyle(
        fontSize: ScreenSize().getScreenHeight(1.3),
        color: Colors.white,
        fontWeight: FontWeight.w400);
  }

  tabledata() {
    return TextStyle(
        fontSize: ScreenSize().getScreenHeight(1.2),
        color: SECONDARY_COLOR,
        fontWeight: FontWeight.w400);
  }

  sortText() {
    return TextStyle(
        fontSize: ScreenSize().getScreenHeight(1.2),
        color: SECONDARY_COLOR,
        fontWeight: FontWeight.w600);
  }

  headerTitle() {
    return TextStyle(
        fontSize: ScreenSize().getScreenHeight(1.4),
        color: Colors.white,
        fontWeight: FontWeight.w600);
  }

  homeMenuTitle() {
    return TextStyle(
        fontSize: ScreenSize().getScreenHeight(1.6),
        color: SECONDARY_COLOR,
        fontWeight: FontWeight.w600);
  }

  homeCountTxt() {
    return TextStyle(
        fontSize: ScreenSize().getScreenHeight(1),
        color: Colors.white,
        fontWeight: FontWeight.w400);
  }

  homeCntText() {
    return TextStyle(
        fontSize: ScreenSize().getScreenHeight(2.5),
        color: Colors.white,
        fontWeight: FontWeight.w400);
  }

  footercopyRight() {
    return TextStyle(
        color: Colors.black87,
        fontSize: ScreenSize().getScreenHeight(0.8),
        decoration: TextDecoration.none,
        fontWeight: FontWeight.w400);
  }
}
