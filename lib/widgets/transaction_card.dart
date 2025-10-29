import 'package:piggy_bank/constant.dart';
import 'package:piggy_bank/utils/currency_format.dart';
import 'package:piggy_bank/utils/screen_size.dart';
import 'package:piggy_bank/dailog/reciept_modal.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

class TransactionCard extends StatefulWidget {
  final String fullName;
  final String accountID;
  final String? status;
  final Function action;
  const TransactionCard({super.key, required this.fullName, required this.accountID, required this.action,   this.status});

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

Color btnColor = Colors.black26;
Color iconColor = SECONDARY_COLOR;

class _TransactionCardState extends State<TransactionCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
       widget.action();
      },
      child:AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        // Removed color: Colors.white
        margin: EdgeInsets.zero,
        decoration:  BoxDecoration(
          color: PRIMARY_COLOR, // Moved color here
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border: Border.all(
            color: SECONDARY_COLOR.withValues(alpha: 0.2), // Border color
            width: 1, // Border width
          ),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(
            horizontal: ScreenSize().getScreenHeight(1),
          ),
          dense: true,
          leading: Icon(
            Icons.person_pin,
            color: SECONDARY_COLOR.withOpacity(0.9),
            size: ScreenSize().getScreenHeight(4),
          ),
          title: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Name: ',
                  style: TextStyle(
                    fontSize: ScreenSize().getScreenHeight(1.4),
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: widget.fullName,
                  style: TextStyle(
                    fontSize: ScreenSize().getScreenHeight(1.4),
                    color: Colors.black87,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          subtitle: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Acnt ID: ',
                  style: TextStyle(
                    fontSize: ScreenSize().getScreenHeight(1.2),
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: widget.accountID,
                  style: TextStyle(
                    fontSize: ScreenSize().getScreenHeight(1.2),
                    color: Colors.black87,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
           trailing:   Container(
             width: ScreenSize().getScreenWidth(20),
             padding: EdgeInsets.symmetric(vertical:6,  ),
             decoration: BoxDecoration(
               color: getStatusColor(widget.status!).withValues(alpha: 0.1),
                   borderRadius: BorderRadius.circular(80),
               border: Border.all(width: 1.0, color:getStatusColor(widget.status!) )
             ),
             child:  Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Text(
                   widget.status??"",
                   style: TextStyle(
                     color: getStatusColor(widget.status!),
                     fontSize:MediaQuery.of(context).size. height * 0.012,
                   ),
                 ),
                 SizedBox(
                   width: 1,
                 ),
                 // Add some spacing between text and icon
                 Icon(
                   Icons.circle, // Replace with the circle dot icon
                   size: 14, // Adjust the size of the icon
                   color: getStatusColor(widget.status!)
                       .withOpacity(0.8), // Match the text color
                 )
               ],
             ),
           )

        ),
      )
    );
  }
}
