//
// import 'dart:convert';
//
// LoginData loginDataFromJson(String str) => LoginData.fromJson(json.decode(str));
//
// String loginDataToJson(LoginData data) => json.encode(data.toJson());
//
// class LoginData {
//     String userName;
//     String password;
//
//     LoginData({
//         required this.userName,
//         required this.password,
//     });
//
//     factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
//         userName: json["userName"],
//         password: json["password"],
//     );
//
//     Map<String, dynamic> toJson() => {
//         "userName": userName,
//         "password": password,
//     };
// }
