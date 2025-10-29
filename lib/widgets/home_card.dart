import 'package:flutter/material.dart';

import '../constant.dart';
import '../utils/screen_size.dart';

class HomeCard extends StatefulWidget {
  final String text;
  final String tapIcon;
  final bool squareImage;
  final bool leftDivider;
  final bool rightDivider;
  final bool bottomDivider;
  final bool topDivider;
  final Function btnAction;
  const HomeCard({
    super.key,
    required this.text,
    required this.tapIcon,
    required this.squareImage,
    required this.leftDivider,
    required this.rightDivider,
    required this.bottomDivider,
    required this.topDivider,
    required this.btnAction,
  });

  @override
  State<HomeCard> createState() => _HomeCardState();
}

Color btnColor = PRIMARY_COLOR;
Color iconColor = SECONDARY_COLOR;

class _HomeCardState extends State<HomeCard> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: GestureDetector(
        // ignore: avoid_types_as_parameter_names
        onTapDown: (TapDownDetails details) {
          setState(() {
            btnColor = SECONDARY_COLOR;
            iconColor = PRIMARY_COLOR;
          });
        },
        onTapUp: (TapUpDetails details) {
          setState(() {
            // Revert to original colors when the finger is released
            btnColor = PRIMARY_COLOR;
            iconColor = SECONDARY_COLOR;
          });
        },
        onTap: () {
          widget.btnAction();
        },
        child: Container(
          height: ScreenSize().getScreenHeight(16),
          width: double.infinity,
          decoration: BoxDecoration(
            color: btnColor,

            border: Border(
              left: BorderSide(
                //                   <--- left side
                color:
                    widget.leftDivider ? SECONDARY_COLOR : Colors.transparent,
                width: ScreenSize().getScreenHeight(0.07),
              ),
              right: BorderSide(
                //                   <--- left side
                color:
                    widget.rightDivider ? SECONDARY_COLOR : Colors.transparent,
                width: ScreenSize().getScreenHeight(0.07),
              ),
              top: BorderSide(
                //                    <--- top side
                color: widget.topDivider ? SECONDARY_COLOR : Colors.transparent,
                width: ScreenSize().getScreenHeight(0.07),
              ),
              bottom: BorderSide(
                //                    <--- top side
                color:
                    widget.bottomDivider ? SECONDARY_COLOR : Colors.transparent,
                width: ScreenSize().getScreenHeight(0.07),
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                widget.tapIcon,
                width: widget.squareImage
                    ? ScreenSize().getScreenHeight(3.5)
                    : ScreenSize().getScreenHeight(4),
                height: ScreenSize().getScreenHeight(4),
                fit: BoxFit.fill,
                color: iconColor,
              ),
              SizedBox(
                height: ScreenSize().getScreenHeight(1),
              ),
              Text(
                widget.text,
                style: TextStyle(
                    fontSize: ScreenSize().getScreenHeight(1.5),
                    color: iconColor,
                    fontWeight: FontWeight.w400),
              )
            ],
          ),
        ),
      ),
    );
  }
}
