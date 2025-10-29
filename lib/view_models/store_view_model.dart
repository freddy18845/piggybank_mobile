
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Repository/customer_DB.dart';
import '../Repository/transactions_DB.dart';
import '../Repository/user_auth.dart';
import '../constant.dart';
import '../utils/user_Manager.dart';
import '../utils/utils.dart';





class StoreViewModel extends ChangeNotifier {
  final TransactionsDBServices instanceTransaction = TransactionsDBServices();
  final CustomerDBServices instanceCM = CustomerDBServices();



   double totalDepositAmount = 0.00;
   int totalDepositCount = 0;
double totalTransaction = 0.00;
  int totalCustomers = 0;
  int transactionCount = 0;

  bool isProcessing = false;
  bool isRememberMeChecked = false;
  String  staffId= '';
  final Map<String, TextEditingController> controllers = {
    "email": TextEditingController(),
    "password": TextEditingController(),
    "password_reset_email": TextEditingController(),
  };

  void setDashboardData() async {
    final userInfo = UserManager().getUserData();
    if(userInfo.role == "Administrator"){
      totalDepositAmount = 0.0;
      transactionCount = transactionsStorage.length;
    }
    totalCustomers = customersStorage.length;

    for (var entry in transactionsStorage.entries) {

      String amountStr = entry.value["transactionAmount"]?.toString() ?? "0";

        totalDepositAmount += double.tryParse(amountStr) ?? 0;
    }

      notifyListeners();

  }

  /// Save credentials when "Remember Me" is checked
  Future<void> setRememberMe() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', controllers['email']!.text);
    await prefs.setString('password', controllers['password']!.text);
  }

  Future<void> setRememberMeCheck( bool newIsRememberMeChecked) async {
    isRememberMeChecked = newIsRememberMeChecked;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isRememberMe', isRememberMeChecked);
    if(isRememberMeChecked==false){
      clearRememberMe();
    }

  }

  /// Load stored credentials
  Future<void> getRememberMe() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    controllers['email']!.text = prefs.getString('email') ?? '';  // Prevent null crash
    controllers['password']!.text = prefs.getString('password') ?? '';
    isRememberMeChecked = prefs.getBool('isRememberMe') ?? false;
    if(controllers['email']!.text.isEmpty &&  controllers['password']!.text.isEmpty){
      emptyField();
    }
    isProcessing = false;
    notifyListeners();
  }

  /// Clear stored credentials (optional for logout)
  Future<void> clearRememberMe() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    await prefs.remove('password');
    controllers['email']!.clear();
    controllers['password']!.clear();
    notifyListeners();
  }





 void signIn( context){

    if (controllers['email']!.text.isEmpty ||
        controllers['password']!.text.isEmpty) {
      showCustomSnackBar(context, "Login Failed: Please enter all fields!", isSuccess: false);


      return;
    }else{
      isProcessing = true;
      notifyListeners();
      UserAuth instance = UserAuth();
      if(isRememberMeChecked){
        setRememberMe();
      }
      instance.signInUser(context, controllers['email']!.text, controllers['password']!.text);
    }

  }
  void emptyField() {
    controllers['email']?.text= '';
    controllers['password']?.text ='';
    notifyListeners(); // Ensure this is inside a ChangeNotifier
  }
  void reset( context){
    if (controllers['password_reset_email']!.text.isEmpty
    ) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Center(child:Text("Please  Enter Email")),
          backgroundColor: Colors.red,
        ),

      );
      return;
    }else{
      isProcessing = true;
      notifyListeners();
      UserAuth instance = UserAuth();
      instance.resetPassword(context, controllers['password_reset_email']!.text);

    }
  }

  Future<void> disableLoader() async {
    isProcessing = false;
    controllers['email']?.text= '';
    controllers['password']?.text ='';
    notifyListeners();
  }
  getSelectedTable( String table){

    notifyListeners();
  }


}
