import 'package:piggy_bank/constant.dart';
import 'package:piggy_bank/utils/currency_format.dart';
import 'package:piggy_bank/utils/fonts_style.dart';
import 'package:piggy_bank/utils/screen_size.dart';
import 'package:piggy_bank/widgets/button.dart';

import 'package:flutter/material.dart';

detailTxnModal(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    //barrierColor: Colors.transparent,

    builder: (BuildContext context) {
      return AlertDialog(
        alignment: Alignment.topCenter,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        contentPadding: const EdgeInsets.all(0),
        insetPadding: EdgeInsets.only(top: ScreenSize().getScreenHeight(20)),
        content: Container(
          height: ScreenSize().getScreenHeight(32.5),
          width: ScreenSize().getScreenWidth(90),
          padding: EdgeInsets.symmetric(
            vertical: ScreenSize().getScreenHeight(2),
            horizontal: ScreenSize().getScreenWidth(4),
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Transaction Data",
                      style: TextStyle(
                          fontSize: ScreenSize().getScreenHeight(1.6),
                          fontWeight: FontWeight.w800,
                          color: SECONDARY_COLOR)),
                ],
              ),
              const SizedBox(
                width: double.infinity,
                child: Divider(
                  thickness: 1,
                ),
              ),
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: 'First Name:', // Main part of the number
                    style: FontsStyle().recieptTitle()),
                TextSpan(text: '  John', style: FontsStyle().recieptText()),
              ])),
              SizedBox(
                height: ScreenSize().getScreenHeight(0.5),
              ),
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: 'Middle Name:', // Main part of the number
                    style: FontsStyle().recieptTitle()),
                TextSpan(text: '  Kwame', style: FontsStyle().recieptText()),
              ])),
              SizedBox(
                height: ScreenSize().getScreenHeight(0.5),
              ),
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: 'Last Name:', // Main part of the number
                    style: FontsStyle().recieptTitle()),
                TextSpan(text: '  Doe', style: FontsStyle().recieptText()),
              ])),
              SizedBox(
                height: ScreenSize().getScreenHeight(0.5),
              ),
              const SizedBox(
                width: double.infinity,
                child: Divider(
                  thickness: 1,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Agent ID:", style: FontsStyle().recieptTitle()),
                  Text("ADS21", style: FontsStyle().recieptText())
                ],
              ),
              SizedBox(
                height: ScreenSize().getScreenHeight(0.1),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Account ID:", style: FontsStyle().recieptTitle()),
                  Text("ADS214342354", style: FontsStyle().recieptText())
                ],
              ),
              SizedBox(
                height: ScreenSize().getScreenHeight(0.1),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Amount:", style: FontsStyle().recieptTitle()),
                  Text("GHS${Currency().format("20")}",
                      style: TextStyle(
                          fontSize: ScreenSize().getScreenHeight(1.6),
                          color: GREEN_COLOR,
                          fontWeight: FontWeight.w400))
                ],
              ),
              const SizedBox(
                width: double.infinity,
                child: Divider(
                  thickness: 1,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Btn(
                        btn: RED_COLOR,
                        btnText: 'Close',
                        btnAction: () {
                          Navigator.pop(context);
                        }),
                  ),
                  SizedBox(
                    width: ScreenSize().getScreenWidth(4),
                  ),
                  Expanded(
                      child: Btn(
                          btn: SECONDARY_COLOR,
                          btnText: 'SMS',
                          btnAction: () {})),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
