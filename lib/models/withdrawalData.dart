// To parse this JSON data, do
//
//     final withdrawalData = withdrawalDataFromJson(jsonString);

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

WithdrawalData withdrawalDataFromJson(String str) =>
    WithdrawalData.fromJson(json.decode(str));

String withdrawalDataToJson(WithdrawalData data) =>
    json.encode(data.toJson());

class WithdrawalData {
  String? customerId;
  String? transactionType;
  String? description;
  String? transactionAmount;
  String? companyID;
  String? staffId;
  DateTime? createDate;

  WithdrawalData({
    this.customerId,
    this.transactionType,
    this.description,
    this.transactionAmount,
    this.companyID,
    this.staffId,
    this.createDate,
  });

  factory WithdrawalData.fromJson(Map<String, dynamic> json) => WithdrawalData(
    customerId: json["customerId"],
    transactionType: json["transactionType"],
    description: json["description"],
    transactionAmount: json["transactionAmount"],
    companyID: json["companyID"],
    staffId: json["StaffID"],
    createDate: _toDateTime(json["createDate"]),
  );

  Map<String, dynamic> toJson() => {
    "customerId": customerId,
    "transactionType": transactionType,
    "description": description,
    "transactionAmount": transactionAmount,
    "companyID": companyID,
    "StaffID": staffId,
    "createDate":
    createDate != null ? Timestamp.fromDate(createDate!) : null,
  };

  // 🔸 Handle Firestore Timestamps or Strings
  static DateTime? _toDateTime(dynamic value) {
    if (value == null) return null;
    if (value is Timestamp) return value.toDate();
    if (value is String) return DateTime.tryParse(value);
    return null;
  }

  // 🔸 Handle numeric conversions safely
  static double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }
}
