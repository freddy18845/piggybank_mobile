import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

DepositData depositDataFromJson(String str) =>
    DepositData.fromJson(json.decode(str));

String depositDataToJson(DepositData data) => json.encode(data.toJson());

class DepositData {
  String? companyID;
  String? staffId;
  String? customerId;
  DateTime? createDate;
  DateTime? transactionDate;
  String? paymentMethod;
  String? transactionType;
  String? transactionAmount;
  String? walletId;
  String? transactionId;

  DepositData({
    this.companyID,
    this.staffId,
    this.customerId,
    this.createDate,
    this.transactionDate,
    this.paymentMethod,
    this.transactionType,
    this.transactionAmount,
    this.walletId,
    this.transactionId,
  });

  /// 🔹 From Firestore or JSON map
  factory DepositData.fromJson(Map<String, dynamic> json) => DepositData(
    companyID: json["companyID"],
    staffId: json["staffID"],
    customerId: json["customerId"],
    createDate: _toDateTime(json["createDate"]),
    transactionDate: _toDateTime(json["transactionDate"]),
    paymentMethod: json["paymentMethod"],
    transactionType: json["transactionType"],
    transactionAmount: json["transactionAmount"],
    walletId: json["walletID"],
    transactionId: json["transactionId"],
  );

  /// 🔹 Convert to JSON for saving
  Map<String, dynamic> toJson() => {
    "companyID": companyID,
    "staffID": staffId,
    "customerId": customerId,
    "createDate": createDate != null ? Timestamp.fromDate(createDate!) : null,
    "transactionDate":
    transactionDate != null ? Timestamp.fromDate(transactionDate!) : null,
    "paymentMethod": paymentMethod,
    "transactionType": transactionType,
    "transactionAmount": transactionAmount,
    "walletID": walletId,
    "transactionId": transactionId,
  };

  /// 🔸 Helper to handle Firestore Timestamps or Strings
  static DateTime? _toDateTime(dynamic value) {
    if (value == null) return null;
    if (value is Timestamp) return value.toDate();
    if (value is String) return DateTime.tryParse(value);
    return null;
  }

  /// 🔸 Helper to handle String/double conversions safely
  static double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }
}
