import 'package:flutter/material.dart';
import 'package:piggy_bank/utils/screen_size.dart';
import '../models/customerData.dart';


import 'loader.dart';

class LoadingDailog extends StatefulWidget {
  final BuildContext parentContext;

  const LoadingDailog({
    Key? key,
    required this.parentContext,
  }) : super(key: key);

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => LoadingDailog(
        parentContext: context,
      ),
    );
  }

  @override
  State<LoadingDailog> createState() => _LoadingDailogState();
}

class _LoadingDailogState extends State<LoadingDailog> {
  bool isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      contentPadding: EdgeInsets.zero,
      //insetPadding: EdgeInsets.only(top: ScreenSize().getScreenHeight(20)),
      content: Container(
        height: ScreenSize().getScreenHeight(22),
        width: ScreenSize().getScreenWidth(90),
        padding: EdgeInsets.symmetric(
          vertical: ScreenSize().getScreenHeight(2),
          horizontal: ScreenSize().getScreenWidth(4),
        ),
        decoration: const BoxDecoration(color: Colors.white),
        child: Loader(),
      ),
    );
  }
}
