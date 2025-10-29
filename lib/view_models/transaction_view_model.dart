

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Repository/transactions_DB.dart';
import '../constant.dart';
import '../models/depositData.dart';
import '../utils/utils.dart';





class TransactionViewModel extends ChangeNotifier {
  final TransactionsDBServices instanceTransaction = TransactionsDBServices();
  DepositData depositData = DepositData();


  // double totalDepositAmount = 0.00;
  // int totalDepositCount = 0;
  final Map<String, TextEditingController> searchControllers = {
    "accountID": TextEditingController(),
    "endDate": TextEditingController(),
    "startDate": TextEditingController(),
  };

  bool isProcessing = false;


  void setCustomerData( String accountNum, String lastName, String middleName,String firstName,) {

    notifyListeners();
  }
  void setTransactionData( ) {
    searchControllers["startDate"]!.text =  DateFormat('yyyy-MM-dd').format(DateTime.parse(searchControllers["startDate"]!.text));
    searchControllers["endDate"]!.text =  DateFormat('yyyy-MM-dd').format(DateTime.parse( searchControllers["endDate"]!.text));
    notifyListeners();
  }

  void emptyFields( ) {
    searchControllers["startDate"]!.text = '';
    searchControllers["endDate"]!.text =  '';
    searchControllers["accountID"]!.text =  '';
    notifyListeners();
  }






}
