// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../utils/screen_size.dart';

class RoundBtn extends StatelessWidget {
  final Widget btnLabel;

  const RoundBtn({
    super.key,
    required this.btnLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenSize().getScreenHeight(6),
      width: ScreenSize().getScreenHeight(6),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(
          ScreenSize().getScreenHeight(3),
        ),
        //  border: Border.all(width: 3, color: outerColor),
      ),
      child: Center(child: btnLabel),
    );
  }
}
