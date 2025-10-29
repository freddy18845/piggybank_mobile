// lib/Repository/sms_DB.dart
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../utils/company_Manager.dart';
import '../utils/utils.dart';

class SMSDBServices {
  final String baseUrl = "https://api.smsonlinegh.com/v5/message/sms/send"; // example
  final String apiKey = "b1ac9765ed4f9d7fcaf94dd0b24cdbef0d72b605d182f770857a72f25e74e974"; // replace with your SMSOnlineGH key

  Future<bool> purchaseSMS(
      String companyId,
      String packageName,
      int totalCredits,
      double totalPrice,
      ) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/purchase"),
        headers: {
          "Host":"api.smsonlinegh.com",
          "Accept":"application/json",
          "Authorization": "key $apiKey",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "companyId": companyId,
          "packageName": packageName,
          "credits": totalCredits,
          "amount": totalPrice,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print("Purchase failed: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Error purchasing SMS: $e");
      return false;
    }
  }

  Future<double> fetchCurrentBalance() async {
    const String baseUrl = "http://localhost:4000"; // or your deployed proxy URL

    try {
      final response = await http.get(
        Uri.parse("$baseUrl/check-balance"),
        headers: {
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Ensure we safely parse balance (could be string or number)
        final balance = data["balance"];
        if (balance is num) {
          return balance.toDouble();
        } else if (balance is String) {
          return double.tryParse(balance) ?? 0.0;
        } else {
          return 0.0;
        }
      } else {
        print("❌ Failed to fetch balance: ${response.body}");
        return 0.0;
      }
    } catch (e) {
      print("⚠️ Error fetching balance: $e");
      return 0.0;
    }
  }

  sendSMS({
    required List<String> recipient,
    required String message,
    required bool isRegister,
    required BuildContext context
  }) async {
    final senderId = CompanyManager().getCompanyData().senderId;

    // ✅ use your local Node.js proxy instead of direct API
    if (senderId != "None") {
      try {
        final body = jsonEncode({
          "sender": isRegister?'PiggyBank':senderId,
          "text": message,
          "type": 0,
          "destinations": recipient,
        });

        print("✅ Request Body: $body");

        // 👇 send through your local proxy
        final response = await http.post(
          Uri.parse('http://localhost:4000/send-sms'),
          headers: {
            "Content-Type": "application/json",
          },
          body: body,
        );
        if (response.statusCode == 200) {
          print("✅ SMS sent successfully: ${response.body}");

        } else {
          showCustomSnackBar(
            context,
            "Failed to send SMS: ${response.body}",
            isSuccess: false,
          );
          print("❌ Failed to send SMS: ${response.body}");

        }
      } catch (e) {
        print("🚨 Error sending SMS: $e");
        showCustomSnackBar(
          context,
          "Error sending SMS",
          isSuccess: false,
        );
      }
    } else {
      showCustomSnackBar(
        context,
        "Error sending SMS",
        isSuccess: false,
      );
    }
  }

}
