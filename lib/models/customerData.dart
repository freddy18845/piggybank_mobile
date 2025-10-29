// To parse this JSON data, do
//
//     final customerData = customerDataFromJson(jsonString);

import 'dart:convert';

CustomerData customerDataFromJson(String str) => CustomerData.fromJson(json.decode(str));

String customerDataToJson(CustomerData data) => json.encode(data.toJson());

class CustomerData {
  String? firstName;
  String? middleName;
  String? lastName;
  String? idCardType;
  String? idNumber;
  String? contact;
  String? email;
  String? occupation;
  String? gpsAddress;
  String? location;
  String? nextOfKinName;
  String? relation;
  String? nextOfKinContact;
  String? nextOfKinOccupation;
  String? whatsappNo;
  String? companyID;
  String? dob;
  String? staffId;
  String? customerId;
  String? status;

  CustomerData({
    this.firstName,
    this.middleName,
    this.lastName,
    this.idCardType,
    this.idNumber,
    this.contact,
    this.email,
    this.occupation,
    this.gpsAddress,
    this.location,
    this.nextOfKinName,
    this.relation,
    this.nextOfKinContact,
    this.nextOfKinOccupation,
    this.whatsappNo,
    this.companyID,
    this.dob,
    this.staffId,
    this.customerId,
    this.status,
  });

  factory CustomerData.fromJson(Map<String, dynamic> json) => CustomerData(
    firstName: json["firstName"],
    middleName: json["middleName"],
    lastName: json["lastName"],
    idCardType: json["idCardType"],
    idNumber: json["idNumber"],
    contact: json["contact"],
    email: json["email"],
    occupation: json["occupation"],
    gpsAddress: json["gpsAddress"],
    location: json["location"],
    nextOfKinName: json["nextOfKinName"],
    relation: json["relation"],
    nextOfKinContact: json["nextOfKinContact"],
    nextOfKinOccupation: json["nextOfKinOccupation"],
    whatsappNo: json["whatsappNo"],
    companyID: json["companyID"],
    dob: json["dob"],
    staffId: json["staffID"],
    customerId:json["customerId"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "middleName": middleName,
    "lastName": lastName,
    "idCardType": idCardType,
    "idNumber": idNumber,
    "contact": contact,
    "email": email,
    "occupation": occupation,
    "gpsAddress": gpsAddress,
    "location": location,
    "nextOfKinName": nextOfKinName,
    "relation": relation,
    "nextOfKinContact": nextOfKinContact,
    "nextOfKinOccupation": nextOfKinOccupation,
    "whatsappNo": whatsappNo,
    "companyID": companyID,
    "dob": dob,
    "staffID": staffId,
    "customerId":customerId,
    "status": status,
  };
}
