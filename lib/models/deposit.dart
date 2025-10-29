// To parse this JSON data, do
//
//     final nextOfKingData = nextOfKingDataFromJson(jsonString);

import 'dart:convert';

NextOfKingData nextOfKingDataFromJson(String str) =>
    NextOfKingData.fromJson(json.decode(str));

String nextOfKingDataToJson(NextOfKingData data) => json.encode(data.toJson());

class NextOfKingData {
  String firstName;
  String lastName;
  String middleName;
  String accountNum;
  String amount;
  String paymentType;
  String? momoId;

  NextOfKingData({
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.accountNum,
    required this.amount,
    required this.paymentType,
    this.momoId,
  });

  factory NextOfKingData.fromJson(Map<String, dynamic> json) => NextOfKingData(
        firstName: json["firstName"],
        lastName: json["lastName"],
        middleName: json["MiddleName"],
        accountNum: json["accountNum"],
        amount: json["amount"],
        paymentType: json["paymentType"],
        momoId: json["momoID"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "MiddleName": middleName,
        "accountNum": accountNum,
        "amount": amount,
        "paymentType": paymentType,
        "momoID": momoId,
      };
}
