// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

// const Color BACKGROUND_PAIR_COLOR = Color.fromRGBO(241, 246, 249, 1);
const Color PRIMARY_COLOR = Color.fromRGBO(236, 238, 250, 1);
const Color SECONDARY_COLOR = Color.fromRGBO(0, 21, 80, 1);
const Color GREEN_COLOR = Color.fromRGBO(45, 152, 7, 1);
const Color RED_COLOR = Color.fromRGBO(187, 11, 11, 1);
const Color GRAY_COLOR = Colors.black12;
 int totalCustomers = 0;
double totalDepositAmount = 0.00;
int totalDepositCount = 0;
const String APP_NAME = "PIGGY BANK GH.";
String companyName = "SIKA PE DEDE SAVINGS AND LOANS";
String companyID = "";
String userID = "";
const List<String> IMAGES = [
  'logo.png',
  'bg.jpg',
  'bg1.png',
  'amt_card.png',
  'loader_1.gif',
  'logo1.png'
];

const List<String> ASSETS = [
  'topup.png',
  'deposit.png',
  'topup.png',
  'list.png',
  'add_user.png',
  'piggy.png',
  'settings.png',
  'txn.png',
  'home.png',
  'active_home.png',
  'active_settings.png',
  'active_txn.png',
];
Map <String, dynamic> userStorage = {};
Map <String, dynamic>customersStorage = {};
Map <String, dynamic> transactionsStorage = {};
Map <String, dynamic>pendingStorage = {};
final List<String> customerStatus = ['Pending', 'Approved', 'Inactive'];
final List<String> products = ["Deposit", "Withdrawal", "Loans Request"];
final List<String> loanFrequency = ["Daily","Monthly", "Yearly"];
final List<String> dashboardTables = ['Transactions', 'Customers',];
final List<String> deposit = [ "savings", "loans"];
final List<String> items = ['Administrator', 'Supervisor', 'Agent'];