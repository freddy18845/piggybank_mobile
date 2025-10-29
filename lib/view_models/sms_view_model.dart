// lib/Repository/sms_DB.dart
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' as apiClient;
import 'package:piggy_bank/models/companyData.dart';
import '../Repository/campany_DB.dart';
import '../utils/company_Manager.dart';
import '../utils/utils.dart';

class SMSDBServices {
  final String baseUrl = "https://api.smsonlinegh.com/v5/message/sms/send"; // example
  final String apiKey = "b1ac9765ed4f9d7fcaf94dd0b24cdbef0d72b605d182f770857a72f25e74e974"; // replace with your SMSOnlineGH key
  CampanyDBService instance = CampanyDBService();


  sendSMS({
    required List<String> recipient,
    required String message,
    required BuildContext context,
  }) async {
    final CompanyData companyData = CompanyManager().getCompanyData();

    try {
      final smsCount = int.tryParse(companyData.smsCount.toString()) ?? 0;

      if (companyData.senderId != "None" && smsCount > 0) {
        final uri = Uri.parse('https://api.smsonlinegh.com/v5/message/sms/send');
// TODO: Check if token is valid, use refresh token etc.
        final response = await apiClient.post(
          uri,
          headers: { "Authorization": 'key ${apiKey}',
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
          body: json.encode({
            "sender": companyData.senderId,
            "text": message,
            "type": 0,
            "destinations": recipient,
          }),
        );

        if (response.statusCode == 200) {
          instance.updateCompanySMS(context, companyData.companyId!);
          debugPrint("✅ SMS sent successfully: ${response.body}");
        } else {
          showCustomSnackBar(
            context,
            "Failed to send SMS: ${response.body}",
            isSuccess: false,
          );
          debugPrint("❌ Failed to send SMS: ${response.body}");
        }
      } else {
        showCustomSnackBar(
          context,
          "You're out of SMS credits.",
          isSuccess: false,
        );
      }
    } catch (e) {
      debugPrint("🚨 Error sending SMS: $e");
      showCustomSnackBar(
        context,
        "Error sending SMS",
        isSuccess: false,
      );
    }
  }
}

// final response = await http.get(Uri.parse('http://10.0.2.2:4000/check-balance'));
//
// if (response.statusCode == 200) {
// final data = jsonDecode(response.body);
// print("💰 SMS Balance: $data");
// } else {
// print("❌ Failed to fetch balance: ${response.body}");
// }