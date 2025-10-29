
import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
  String companyId;
  String gender;
  String staffId;
  String userName;
  String role;

  UserData({
    required this.companyId,
    required this.gender,
    required this.staffId,
    required this.userName,
    required this.role,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    companyId: json["companyID"],
    gender: json["gender"],
    staffId: json["staffId"],
    userName: json["userName"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "companyID": companyId,
    "gender": gender,
    "staffId": staffId,
    "userName": userName,
    "role": role,
  };
}
