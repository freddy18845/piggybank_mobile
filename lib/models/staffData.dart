// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

import 'dart:convert';

StaffData staffDataFromJson(String str) => StaffData.fromJson(json.decode(str));

String staffDataToJson(StaffData data) => json.encode(data.toJson());

class StaffData {
  String? dob;
  String? gender;
  String? idCardType;
  String? email;
  String? gpsAddress;
  String? staffId;
  String? middleName;
  String? companyId;
  String? role;
  String? lastName;
  String? location;
  String? firstName;
  String? idNum;
  int? contact;

  StaffData({
    this.dob,
    this.gender,
    this.idCardType,
    this.email,
    this.gpsAddress,
    this.staffId,
    this.middleName,
    this.companyId,
    this.role,
    this.lastName,
    this.location,
    this.firstName,
    this.idNum,
    this.contact,
  });

  factory StaffData.fromJson(Map<String, dynamic> json) => StaffData(
    dob: json["dob"],
    gender: json["gender"],
    idCardType: json["idCardType"],
    email: json["email"],
    gpsAddress: json["gpsAddress"],
    staffId: json["StaffID"],
    middleName: json["middleName"],
    companyId: json["companyID"],
    role: json["role"],
    lastName: json["lastName"],
    location: json["location"],
    firstName: json["firstName"],
    idNum: json["idNum"],
    contact: json["contact"],
  );

  Map<String, dynamic> toJson() => {
    "dob": dob,
    "gender": gender,
    "idCardType": idCardType,
    "email": email,
    "gpsAddress": gpsAddress,
    "StaffID": staffId,
    "middleName": middleName,
    "companyID": companyId,
    "role": role,
    "lastName": lastName,
    "location": location,
    "firstName": firstName,
    "idNum": idNum,
    "contact": contact,
  };
}
