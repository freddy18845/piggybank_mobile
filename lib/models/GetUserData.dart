// To parse this JSON data, do
//
//     final getUserData = getUserDataFromJson(jsonString);

import 'dart:convert';

GetUserData getUserDataFromJson(String str) => GetUserData.fromJson(json.decode(str));

String getUserDataToJson(GetUserData data) => json.encode(data.toJson());

class GetUserData {
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
  String? password;
  String? idNum;
  int? contact;
  String? documentId;

  GetUserData({
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
    this.password,
    this.idNum,
    this.contact,
    this.documentId,
  });

  factory GetUserData.fromJson(Map<String, dynamic> json) => GetUserData(
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
    password: json["password"],
    idNum: json["idNum"],
    contact: json["contact"],
    documentId: json["documentId"],
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
    "password": password,
    "idNum": idNum,
    "contact": contact,
    "documentId": documentId,
  };
}
