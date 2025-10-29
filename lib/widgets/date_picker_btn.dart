import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constant.dart';
import '../utils/screen_size.dart';

Widget dateButton(
    {required String date,
      required VoidCallback onTap,
      required bool isActive}) {
  return Expanded(
    flex: 5,
    child: InkWell(
      onTap: onTap,
      child: Container(
        height: ScreenSize().getScreenHeight(5),
        decoration: BoxDecoration(
          color: SECONDARY_COLOR.withOpacity(0.1),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            width: 1,
            color: SECONDARY_COLOR.withOpacity(0.8),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.date_range,
              size: 22,
              color: SECONDARY_COLOR.withOpacity(0.5),
            ),
            const SizedBox(width: 5),
            Flexible(
              child: Text(
                date,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: isActive
                      ? SECONDARY_COLOR
                      : SECONDARY_COLOR.withOpacity(0.8),
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

