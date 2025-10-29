import 'package:piggy_bank/constant.dart';
import 'package:piggy_bank/utils/screen_size.dart';
import 'package:flutter/material.dart';

class Btn extends StatefulWidget {
  final Color btn;
  final Function btnAction;
  final String btnText;

  const Btn({
    super.key,
    required this.btnAction,
    required this.btn,
    required this.btnText,
  });

  @override
  State<Btn> createState() => _BtnState();
}

class _BtnState extends State<Btn> {
  Color btnColor = SECONDARY_COLOR.withOpacity(0.1);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        setState(() {
          btnColor = SECONDARY_COLOR;
        });
      },
      onTapUp: (TapUpDetails details) {
        setState(() {
          // Revert to original colors when the finger is released
          btnColor = SECONDARY_COLOR.withOpacity(0.1);
        });
      },
      onTap: () {
        FocusScope.of(context).unfocus();
        widget.btnAction();
      },
      child: Container(
        height: ScreenSize().getScreenHeight(6),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 1, color: btnColor),
            borderRadius:
                BorderRadius.circular(ScreenSize().getScreenHeight(1))),
        child: Center(
          child: Text(
            widget.btnText,
            style: TextStyle(
                fontSize: ScreenSize().getScreenHeight(1.6),
                color: widget.btn,
                fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
}
