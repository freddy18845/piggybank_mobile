
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Repository/customer_DB.dart';
import '../Repository/transactions_DB.dart';
import '../Repository/user_auth.dart';
import '../utils/utils.dart';





class LockPinViewModel extends ChangeNotifier {
  final TransactionsDBServices instanceTransaction = TransactionsDBServices();
  final CustomerDBServices instanceCM = CustomerDBServices();

  bool isProcessing = false;
  final Map<String, TextEditingController> controllers = {
    "email": TextEditingController(),
    "password": TextEditingController(),
    "confirm_pin": TextEditingController(),
    "pin": TextEditingController(),
  };



  /// Save credentials when "Remember Me" is checked
  Future<void> setLockPin( ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('pin', controllers['pin']!.text);
  }
  Future<void> saveLockPin( String pin) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    controllers['pin']!.text = pin;
    await prefs.setString('pin', controllers['pin']!.text);

  }
  /// Load LockPind credentials
  Future<String> getLockPin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    controllers['pin']!.text = prefs.getString('pin') ?? '';
    notifyListeners();
    return controllers['pin']!.text;
  }

  /// Clear LockPind credentials (optional for logout)
  Future<void> clearLockPin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('pin');
    controllers['pin']!.clear();
    notifyListeners();
  }





  Future<void> signInVerification( context) async {

    if (controllers['email']!.text.isEmpty ||
        controllers['password']!.text.isEmpty) {

      showCustomSnackBar(context, "Login Failed: Please enter all fields!", isSuccess: false);
      emptyField();
      return;
    }else{

      notifyListeners();
      UserAuth instance = UserAuth();
      isProcessing = true;
      if(controllers['confirm_pin']?.text==controllers['pin']?.text){
        instance.userVerificationForPinReset(context, controllers['email']!.text, controllers['password']!.text,controllers['pin']!.text);
      }else{
        showCustomSnackBar(context, "Pin Mismatch: Please try again", isSuccess: false);
        emptyField();
      }

      isProcessing = false;
    }

  }
  void emptyField() {
    controllers['email']?.text= '';
    controllers['password']?.text ='';
    controllers['confirm_pin']?.text ='';
    controllers['pin']?.text ='';
    notifyListeners(); // Ensure this is inside a ChangeNotifier
  }
 
 
  


}
