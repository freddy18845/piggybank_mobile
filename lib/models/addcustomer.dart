import 'dart:io';

import 'dart:convert';

NewCustomerData newCustomerDataFromJson(String str) =>
    NewCustomerData.fromJson(json.decode(str));

String newCustomerDataToJson(NewCustomerData data) =>
    json.encode(data.toJson());

class NewCustomerData {
  String firstName;
  String lastName;
  String? middleName;
  String nationalId;
  File passportPic;
  String phoneNumber;
  String accountNum;
  String location;
  String dateOfBirth;
  String gender;
  String? otherNumber;
  String? email;
  String occupation;

  NewCustomerData({
    required this.firstName,
    required this.lastName,
    this.middleName,
    required this.nationalId,
    required this.passportPic,
    required this.phoneNumber,
    required this.accountNum,
    required this.location,
    required this.dateOfBirth,
    required this.gender,
    this.otherNumber,
    this.email,
    required this.occupation,
  });

  factory NewCustomerData.fromJson(Map<String, dynamic> json) =>
      NewCustomerData(
        firstName: json["firstName"],
        lastName: json["lastName"],
        middleName: json["middleName"],
        nationalId: json["nationalID"],
        passportPic: json["passportPic"],
        phoneNumber: json["phoneNumber"],
        accountNum: json["accountNum"],
        location: json["location"],
        dateOfBirth: json["dateOfBirth"],
        gender: json["gender"],
        otherNumber: json["otherNumber"],
        email: json["email"],
        occupation: json["occupation"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "middleName": middleName,
        "nationalID": nationalId,
        "passportPic": passportPic,
        "phoneNumber": phoneNumber,
        "accountNum": accountNum,
        "location": location,
        "dateOfBirth": dateOfBirth,
        "gender": gender,
        "otherNumber": otherNumber,
        "email": email,
        "occupation": occupation,
      };
}
