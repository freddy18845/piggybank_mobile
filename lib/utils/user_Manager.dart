// ignore: file_names
import 'package:piggy_bank/models/userData.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserManager {

  static final UserManager _instance = UserManager._internal();

  factory UserManager() => _instance;

  UserManager._internal();
  UserData userData =
  UserData(companyId: '', gender: '', staffId: '', userName: '', role: '');

  void setUserData({ required String gender, required String cID, required String role, required String userName, required String userID}) {

    userData.companyId = cID;
    userData.gender = gender;
    userData.role = role;
    userData.userName = userName;
    userData.staffId = userID;
  }



  UserData getUserData() {
    return userData;
  }

  // Save to SharedPreferences
  Future<void> saveLoginDetails() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('companyName', userData.companyId);
    await prefs.setString('gender', userData.gender);
    await prefs.setString('userName', userData.userName);
    await prefs.setString('role', userData.role);
    await prefs.setString('userID', userData.staffId);

  }
}