

import 'package:flutter/material.dart';
import '../Repository/transactions_DB.dart';
import '../models/depositData.dart';
import '../models/withdrawalData.dart';
import '../utils/user_Manager.dart';
import '../utils/utils.dart';





class DepositViewModel extends ChangeNotifier {
  final TransactionsDBServices instanceTransaction = TransactionsDBServices();
  DepositData depositData = DepositData();
  WithdrawalData withdrawalData = WithdrawalData();
  final Map<String, TextEditingController> searchControllers = {
    "accountID": TextEditingController(),
    "endDate": TextEditingController(),
    "startDate": TextEditingController(),
  };


  bool isProcessing = false;
   setTransactionData( {required context,required String accountID ,required String amount,required String walletId,required String transactionType, required String deposit,}) {
    final userInfo = UserManager().getUserData();
    depositData
      ..staffId = userInfo.staffId
      ..companyID =  userInfo.companyId
      ..walletId = walletId
      ..customerId =  accountID
      ..transactionAmount = amount
      ..transactionType = deposit =='Savings'? "savings":'loans'
      ..paymentMethod =transactionType
      ..transactionDate = DateTime.now()
      ..transactionId =generateTransactionId()
      ..createDate = DateTime.now();
    instanceTransaction.addTransaction(context, depositData.toJson());
  }


   setWithdrawalData( {required BuildContext context, required String amount, required String accountID} ) {

    //controllers['transactionType']!.text = "withdrawals";
    final userInfo = UserManager().getUserData();
    withdrawalData
      ..staffId = userInfo.staffId
      ..companyID =  userInfo.companyId
      ..description = 'mobile'
      ..customerId =  accountID
      ..transactionAmount = amount
      ..transactionType = 'withdrawals'
      ..createDate = DateTime.now();
    notifyListeners();

    instanceTransaction.addTransaction(context, withdrawalData.toJson());
    // print( withdrawalData.toJson());
  }





}
