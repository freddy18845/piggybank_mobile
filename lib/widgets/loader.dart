import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constant.dart';
import '../utils/screen_size.dart';

class Loader extends StatefulWidget {
  const Loader({super.key});

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Sending Data...",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
        Padding(
          padding: EdgeInsets.symmetric(vertical:ScreenSize().getScreenHeight(2) ),
          child: Image.asset(
            'assets/images/${IMAGES[4]}',
            height: ScreenSize().getScreenHeight(8),
          ),
        ),
        const Text("Please wait...",
            style: TextStyle(
                fontSize: 12,


                fontWeight: FontWeight.w600)),
      ],
    );
    //   Column(
    //   mainAxisAlignment: MainAxisAlignment.start,
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   children: [
    //     SizedBox(height: ScreenSize().getScreenHeight(12)),
    //     SizedBox(
    //       height: ScreenSize().getScreenHeight(7),
    //       width: ScreenSize().getScreenHeight(8),
    //       child: Stack(
    //         alignment: Alignment.center,
    //         children: [
    //           Image.asset(
    //             'assets/images/${IMAGES[4]}',
    //             fit: BoxFit.contain,
    //             opacity: const AlwaysStoppedAnimation(0.5),
    //           ),
    //
    //         ],
    //       ),
    //     ),
    //     const SizedBox(height: 10),
    //     const Text(
    //       "Please Wait",
    //       style: TextStyle(
    //         color: Colors.black,
    //         fontSize: 14,
    //         fontWeight: FontWeight.w500,
    //       ),
    //     ),
    //   ],
    // );
  }
}
