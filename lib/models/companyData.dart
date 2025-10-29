// To parse this JSON data, do
//
//     final companyData = companyDataFromJson(jsonString);

import 'dart:convert';

CompanyData companyDataFromJson(String str) => CompanyData.fromJson(json.decode(str));

String companyDataToJson(CompanyData data) => json.encode(data.toJson());

class CompanyData {
  final String? name;
  final String? phone;
  final String? otherPhone;
  final String? companyId;
  final String? registrationId;
  final String? location;
  final String? email;
  final String? status;
  final String? senderId;
  final String? smsCount;
  final String? appLogo;
  final String? subscriptionEndDate;

  CompanyData({
    this.name,
    this.phone,
    this.otherPhone,
    this.companyId,
    this.registrationId,
    this.location,
    this.email,
    this.status,
    this.senderId,
    this.smsCount,
    this.appLogo,
    this.subscriptionEndDate
  });

  CompanyData copyWith({
    String? name,
    String? phone,
    String? otherPhone,
    String? companyId,
    String ? registrationId,
    String? location,
    String? email,
    String? status,
    String? senderId,
    String? smsCount,
    String? appLogo,
    String? subscriptionEndDate
  }) =>
      CompanyData(
        name: name ?? this.name,
        phone: phone ?? this.phone,
        otherPhone: otherPhone ?? this.otherPhone,
        companyId: companyId ?? this.companyId,
        registrationId :registrationId ?? this.registrationId,
        location: location ?? this.location,
        email: email ?? this.email,
        status: status ?? this.status,
        senderId: senderId ?? this.senderId,
        smsCount: smsCount ?? this.smsCount,
        appLogo: appLogo ?? this.appLogo,
        subscriptionEndDate: subscriptionEndDate ?? this.subscriptionEndDate,
      );

  factory CompanyData.fromJson(Map<String, dynamic> json) => CompanyData(
    name: json["name"],
    phone: json["phone"],
    otherPhone: json["otherPhone"],
    companyId: json["companyId"],
    registrationId: json["registrationId"],
    location: json["location"],
    email: json["email"],
    status: json["status"],
    senderId: json["senderId"],
    smsCount: json["smsCount"],
    appLogo: json["appLogo"],
    subscriptionEndDate
        : json["subscriptionEndDate"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "phone": phone,
    "companyId": companyId,
    "registrationId":registrationId,
    "location": location,
    "email": email,
    "status": status,
    "senderId": senderId,
    "smsCount": smsCount,
    "appLogo": appLogo,
    "subscriptionEndDate": subscriptionEndDate,
  };
}
