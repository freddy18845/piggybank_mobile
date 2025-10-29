import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Currency {
  /// Amount formatter. Returns amount with divisions (1500 => 1,500)
  String formatAmount(double amount, BuildContext context) {
    String result = amount.toStringAsFixed(2);
    return result.replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => "${m[1]},");
  }

  String format(amount) {
    try {
      var currencyFormat = NumberFormat(" #,###.00#");
      double newAmount = double.parse(amount.toString());

      if (newAmount == 0) {
        return "0.00";
      }

      String formattedAmount = currencyFormat.format(newAmount);

      return formattedAmount;
    } catch (e) {
      return "0.00";
    }
  }
}
