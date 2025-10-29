import "dart:async";
import "package:flutter/material.dart";

import "package:piggy_bank/constant.dart";

import "../dailog/pin_reset.dart";


class NumPad extends StatefulWidget {
  final bool shuffle;
  final bool shuffleOnce;

  final Color? textColor;
  final int limit;
  final void Function(String value) onInput;
  final void Function()? onCheckedAction;

  const NumPad({
    super.key,
    required this.onInput,
    this.limit = 10,
    this.shuffle = false,
    this.shuffleOnce = false,
    this.textColor,
    this.onCheckedAction,
  });

  @override
  State<NumPad> createState() => _NumPadState();
}

class _NumPadState extends State<NumPad> {
  Set<String> animatingKeys = {};

  String input = "";

  List<List<String>> values = [
    ["1", "2", "3"],
    ["4", "5", "6"],
    ["7", "8", "9"],
    ["X", "0", "back"]
  ];
  void processInput({required String value}) {
    bool updateSubmit = false;

    if (!animatingKeys.contains(value)) {
      setState(() {
        animatingKeys.add(value);
      });

      Future.delayed(const Duration(milliseconds: 150), () {
        setState(() {
          animatingKeys.remove(value);
        });
      });
    }

    if ( value == "X") {
      if (input.isNotEmpty) {
        input = "";
        updateSubmit = true;
      }
    } else if (value == "back") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
        updateSubmit = true;
      }
    } else if (RegExp(r'^[0-9]$').hasMatch(value)) {
      // 🔹 Handle number input
      if (input.length < widget.limit) {
        input += value;
        updateSubmit = true;
      }
    }

    // 🔹 Call the callback when input changes
    if (updateSubmit) {
      widget.onInput(input);
    }

    if (widget.shuffle) shuffleNumSections();
  }


  void shuffleNumSections() {
    values[0].shuffle();
    values[1].shuffle();
    values[2].shuffle();
    setState(() {});
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.shuffleOnce) {
        shuffleNumSections();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  final  width = MediaQuery.of(context).size.width;
  final  height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: width * 0.02,
          horizontal: width * 0.02),
      decoration: BoxDecoration(
        color: PRIMARY_COLOR,
        borderRadius:
        BorderRadius.all(Radius.circular(width * 0.05)),
        border: Border.all(width: 1.0, color: SECONDARY_COLOR.withValues(alpha: 0.2))
      ),
      child: LayoutBuilder(builder: (c, d) {
        int index = 0;
        List<Widget> buttons = [];
        for (int a = 0; a < 4; a++) {
          for (int b = 0; b < 3; b++) {
            index += 1;
            String currentValue = values[a][b];

            buttons.add(
              AnimatedScale(
                scale: 1.0,
                duration: const Duration(milliseconds: 150),
                //curve: Curves.easeOut,
                child: SizedBox(
                  width: (d.maxWidth - ((width * 0.03) * 2)) / 3,
                  height: (d.maxHeight - ((width * 0.03) * 3)) / 4,
                  child: InkWell(
                      onTap: () => processInput(value: currentValue),
                      child: index == 12 || (index == 10)
                          ? Container(
                          height:width * 0.035 ,
                          width: width * 0.1,
                          padding: EdgeInsets.symmetric(
                              horizontal: width * 0.08),
                          child: (index == 10)
                              ? Icon(Icons.clear, size:width * 0.095 , color: Colors.red,)
                              : Icon(Icons.backspace, size:width * 0.09 , color: SECONDARY_COLOR,)
                      ):Stack(
                        children: [
                          Center(
                            child: Text(
                              currentValue,
                              style: TextStyle(
                                fontFamily: "SF Pro Rounded",
                                fontWeight: FontWeight.w300,
                                fontSize:
                                animatingKeys.contains(currentValue)
                                    ? width * 0.015
                                    : (width * 0.08),
                                color: (widget.textColor ?? Colors.black),
                              ),
                            ),
                          ),
                          index == 5
                              ? Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: width * 0.038,
                              height: height * 0.0025,
                              margin: EdgeInsets.only(
                                bottom:height * 0.03,
                              ),
                              decoration: const BoxDecoration(
                                  color: Colors.red),
                            ),
                          )
                              : Container(),
                        ],
                      )
                          ),
                ),
              ),
            );
          }
        }
        return Align(
          alignment: Alignment.topLeft,
          child: Wrap(
            spacing: width * 0.03,
            runSpacing:width * 0.03,
            children: buttons,
          ),
        );
      }),
    );
  }
}
