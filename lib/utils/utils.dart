
import 'dart:math';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:piggy_bank/utils/screen_size.dart';

import '../constant.dart';
import '../main.dart';

void showCustomSnackBar(BuildContext context, String message, {bool isSuccess = true}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: isSuccess
          ? Colors.green
          : Colors.red,
      content: Center(
        child: Text(
          message,
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Manrope",
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.none,
            fontSize: ScreenSize().getScreenWidth(3),
          ),
        ),
      ),
      behavior: SnackBarBehavior.floating,

      duration: const Duration(seconds: 2),
    ),
  );
}

String generateTransactionId() {
  Random random = Random();
  String transactionId = '';

  // Ensure the companyName has at least 3 characters
  String prefix = companyName.length >= 3 ? companyName.substring(0, 3) : companyName.padRight(3, 'X');
  // Ensure the companyName has at least 2 characters for the suffix
  String suffix = companyName.length >= 2 ? companyName.substring(companyName.length - 2) : companyName.padLeft(2, 'X');

  // Generate the middle part of the transaction ID (7 digits)
  for (int i = 0; i < 7; i++) {
    transactionId += random.nextInt(10).toString(); // Generates a digit between 0 and 9
  }

  // Combine prefix, middle, and suffix
  return '${prefix.toUpperCase()}${suffix.toUpperCase()}$transactionId';
}

String setCustomerName(String customerId) {
  // Iterate through map entries
  for (var entry in customersStorage.entries) {
    if (entry.value["customerId"] == customerId) {
      final customer = entry.value;
      return "${customer["firstName"] ?? ''} ${customer["middleName"] ?? ''} ${customer["lastName"] ?? ''}".trim();
    }
  }
  return 'N/A';
}

Map<String, double> getTransactionTotals(Map<String, dynamic> filteredTransactions) {
  double totalSavings = 0.0;
  double totalLoans = 0.0;
  double totalWithdrawals = 0.0;
  double totalRequestLoan = 0.0;

  filteredTransactions.forEach((key, value) {
    final type = (value["transactionType"] ?? "").toString().toLowerCase();
    final amount = double.tryParse(value["transactionAmount"].toString()) ?? 0.0;

    if (type == "savings") {
      totalSavings += amount;
    } else if (type == "loans") {
      totalLoans += amount;
    } else if (type == "withdrawals") {
      totalWithdrawals += amount;
    }else{
       totalRequestLoan += amount;

    }
  });

  return {
    "savings": totalSavings,
    "loans": totalLoans,
    "loans_request": totalRequestLoan,
    "withdrawals": totalWithdrawals,
    "accountBalance": totalSavings - totalWithdrawals,
    "totalDeposits": totalSavings + totalLoans,
  };
}
String formattedDateTime(dynamic dateValue) {
  if (dateValue == null) return '-';

  try {
    DateTime date;

    if (dateValue is Timestamp) {
      date = dateValue.toDate();
    } else if (dateValue is String) {
      date = DateTime.parse(dateValue);
    } else if (dateValue is DateTime) {
      date = dateValue;
    } else {
      return '-';
    }

    // Format the date nicely
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  } catch (e) {
    return '-';
  }
}

Color getStatusColor(String value) {
  if (value == 'Approved') {
    return const Color.fromRGBO(47, 161, 52, 1);
  } else if (value == 'Pending') {
    return  Colors.amber;
  } else {
    return const Color.fromRGBO(213, 38, 7, 1);
  }
}





