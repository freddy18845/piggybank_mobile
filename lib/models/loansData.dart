// To parse this JSON data, do
//
//     final loanData = loanDataFromJson(jsonString);

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

LoanData loanDataFromJson(String str) => LoanData.fromJson(json.decode(str));

String loanDataToJson(LoanData data) => json.encode(data.toJson());

class LoanData {
  String? customerId;
  String? transactionType;
  String? description;
  String? companyID;
  String? staffID;
  DateTime? createDate;
  String? loanTerm;
  String? installmentAmount;
  String? repaymentDuration;
  String? repaymentAmount;
  String? transactionId;
  String? status;

  LoanData({
    this.customerId,
    this.transactionType,
    this.description,
    this.companyID,
    this.staffID,
    this.createDate,
    this.loanTerm,
    this.installmentAmount,
    this.repaymentDuration,
    this.repaymentAmount,
    this.transactionId,
    this.status,
  });

  factory LoanData.fromJson(Map<String, dynamic> json) => LoanData(
    customerId: json["customerId"],
    transactionType: json["transactionType"],
    description: json["description"],
    companyID: json["companyID"],
    staffID: json["StaffID"],
    createDate: _toDateTime(json["createDate"]),
    loanTerm: json["loanTerm"],
    installmentAmount: json["installmentAmount"],
    repaymentDuration: json["repaymentDuration"],
    repaymentAmount: json["repaymentAmount"],
    transactionId: json["transactionId"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "customerId": customerId,
    "transactionType": transactionType,
    "description": description,
    "companyID": companyID,
    "StaffID": staffID,
    "createDate":
    createDate != null ? Timestamp.fromDate(createDate!) : null,
    "loanTerm": loanTerm,
    "installmentAmount": installmentAmount,
    "repaymentDuration": repaymentDuration,
    "repaymentAmount": repaymentAmount,
    "transactionId": transactionId,
    "status": status,
  };

  // 🔸 Handle Firestore Timestamp or String
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
