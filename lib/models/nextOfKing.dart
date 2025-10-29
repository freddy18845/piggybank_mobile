// To parse this JSON data, do
//
//     final nextOfKingData = nextOfKingDataFromJson(jsonString);

import 'dart:convert';

NextOfKingData nextOfKingDataFromJson(String str) =>
    NextOfKingData.fromJson(json.decode(str));

String nextOfKingDataToJson(NextOfKingData data) => json.encode(data.toJson());

class NextOfKingData {
  String fullName;
  String phoneNumber;
  String relation;
  String dateOfBirth;
  String gender;
  String occupation;

  NextOfKingData({
    required this.fullName,
    required this.phoneNumber,
    required this.relation,
    required this.dateOfBirth,
    required this.gender,
    required this.occupation,
  });

  factory NextOfKingData.fromJson(Map<String, dynamic> json) => NextOfKingData(
        fullName: json["fullName"],
        phoneNumber: json["phoneNumber"],
        relation: json["relation"],
        dateOfBirth: json["dateOfBirth"],
        gender: json["gender"],
        occupation: json["occupation"],
      );

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "phoneNumber": phoneNumber,
        "relation": relation,
        "dateOfBirth": dateOfBirth,
        "gender": gender,
        "occupation": occupation,
      };
}
