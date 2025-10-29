import 'package:intl/intl.dart';
import 'package:piggy_bank/models/customerData.dart';
import 'package:piggy_bank/view_models/deposit_view_model.dart';
import 'package:piggy_bank/widgets/button.dart';
import 'package:piggy_bank/widgets/inputFeild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constant.dart';
import '../utils/customer_manager.dart';
import '../utils/fonts_style.dart';
import '../utils/screen_size.dart';
import '../utils/utils.dart';
import '../widgets/header.dart';
import '../widgets/transaction_card.dart';

class DepositAndLoansScreen extends StatefulWidget {
  const DepositAndLoansScreen({super.key});

  @override
  State<DepositAndLoansScreen> createState() => _DepositAndLoansScreenState();
}

class _DepositAndLoansScreenState extends State<DepositAndLoansScreen> {
  String? _selectedValue;
  bool selectedUser = false;
  String? _selectedDeposit = 'Savings';
  Map<String, dynamic> filteredUsers = {};

  Map<String, TextEditingController> controllers = {
    "accountID": TextEditingController(),
    "lastName": TextEditingController(),
    "firstName": TextEditingController(),
    "middleName": TextEditingController(),
    "transactionAmount": TextEditingController(),
    "transactionId": TextEditingController(),
    "paymentMethod": TextEditingController(),
    "walletID": TextEditingController(),
    "depositType": TextEditingController(),
    "location": TextEditingController(),
    "status": TextEditingController(),
    "contact": TextEditingController(),
  };

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // ✅ Safely attach listener AFTER store is ready
      final controller = controllers['transactionAmount'];
      if (controller != null) {
        controller.addListener(() {
          String text = controller.text.replaceAll(RegExp(r'[^0-9]'), '');

          if (text.isEmpty) {
            controller.text = '';
            return;
          }

          // Convert to double with two decimals
          double value = double.parse(text) / 100;
          final formatted = NumberFormat("#,##0.00", "en_US").format(value);

          if (controller.text != formatted) {
            controller.value = TextEditingValue(
              text: formatted,
              selection: TextSelection.fromPosition(
                TextPosition(offset: formatted.length),
              ),
            );
          }
        });
      }
    });
  }

  void _handleRadioValueChange(String? value) {
    setState(() {
      _selectedValue = value;
    });
  }

  void filterCustomers(String query) {
    print("🔍 Searching for: $query");

    if (query.isEmpty) {
      setState(() {
        selectedUser = false;
        filteredUsers = {};
      });
      return;
    }

    // Make sure we actually have data
    if (customersStorage.isEmpty) {
      print("⚠️ No customer data found in storage!");
      return;
    }

    final results = customersStorage.entries.where((entry) {
      return entry.value.values.any((value) {
        final text = value?.toString().toLowerCase() ?? '';
        return text.contains(query.toLowerCase());
      });
    });

    setState(() {
      filteredUsers = Map.fromEntries(results);
    });

    print("✅ Filtered users found: ${filteredUsers.length}");
  }


  void _handleRadioDepositChange(String? value) {
    setState(() {
      _selectedDeposit = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/${IMAGES[2]}'),
              fit: BoxFit.fill,
            ),
          ),
          child: Consumer<DepositViewModel>(
            builder: (context, store, child) {
              return Column(
                children: [
                  const Header(
                    showHome: false,
                    showPrevious: true,
                    showLogo: false,
                    selectedBtn: 'Deposit(Savings Or Loans)',
                    show2Nav: true,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: ScreenSize().getScreenHeight(0.8),
                    ),
                    child: Text(
                      "Search By Account ID or Last Name",
                      style: FontsStyle().subTitleTwo(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenSize().getScreenWidth(6),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Savings", style: FontsStyle().depositTitle()),
                            Radio<String>(
                              value: 'Savings',
                              groupValue: _selectedDeposit,
                              onChanged: _handleRadioDepositChange,
                            ),
                            Text("PayLoans",
                                style: FontsStyle().depositTitle()),
                            Radio<String>(
                              value: 'Loans Repayment',
                              groupValue: _selectedDeposit,
                              onChanged: _handleRadioDepositChange,
                            ),
                          ],
                        ),
                        InputFeild(
                          isOptional: false,
                          isNum: false,
                          icon: Icons.account_balance,
                          inputLimit: 12,
                          placeholder: 'eg. ASA1234556',
                          inputFeild: (value) => filterCustomers(value),
                          inputLabel: 'Account ID',
                          controller: controllers['accountID'],
                        ),
                         !selectedUser
                            ? SizedBox(
                           height: ScreenSize().getScreenHeight(30),
                                  child:
                                      ListView.builder(
                                    itemCount: filteredUsers.length,
                                    itemBuilder: (context, index) {
                                      final listItem = filteredUsers.values.elementAt(index);
                                      // Defensive: make sure the keys exist
                                      final firstName = listItem["firstName"] ?? '';
                                      final middleName = listItem["middleName"] ?? '';
                                      final lastName = listItem["lastName"] ?? '';
                                      final customerId = listItem["customerId"] ?? '';
                                      final status = listItem["status"] ?? 'Unknown';
                                      return TransactionCard(
                                        fullName: "$firstName $middleName $lastName".trim(),
                                        accountID: customerId,
                                        action: () {
                                          setState(() {
                                            selectedUser = true;
                                            controllers['firstName']?.text = firstName;
                                            controllers['middleName']?.text = middleName;
                                            controllers['lastName']?.text = lastName;
                                            controllers['accountID']?.text = customerId;
                                            controllers['status']?.text = status;
                                            controllers['location']?.text =
                                                listItem['location'] ?? '';
                                            controllers['contact']?.text =
                                                listItem['contact'] ?? '';

                                          });

                                          CustomerManager().setCustomerData(
                                            data: CustomerData(
                                              firstName: firstName,
                                              middleName: middleName,
                                              lastName: lastName,
                                              location: listItem['location'] ?? '',
                                              customerId: customerId,
                                              contact: listItem['contact'] ?? '',
                                            ),
                                          );
                                        },
                                        status: status,
                                      );
                                    },
                                  ),

                         ):

                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TransactionCard(
                                    fullName:
                                    "${controllers["firstName"]?.text ?? ''} "
                                        "${controllers["middleName"]?.text ?? ''} "
                                        "${controllers["lastName"]?.text ?? ''}".trim(),
                                    accountID: controllers["accountID"]?.text ?? '',
                                    action: () {},
                                    status: controllers['status']?.text ?? 'Unknown',
                                  ),

                                  SizedBox(
                                      height:
                                          ScreenSize().getScreenHeight(2.5)),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                            padding: EdgeInsets.only(
                                                bottom: ScreenSize()
                                                    .getScreenHeight(1.0)),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text("Cash"),
                                                Radio<String>(
                                                  value: 'Cash',
                                                  groupValue: _selectedValue,
                                                  onChanged:
                                                      _handleRadioValueChange,
                                                ),
                                                const Text("Momo"),
                                                Radio<String>(
                                                  value: 'Momo',
                                                  groupValue: _selectedValue,
                                                  onChanged:
                                                      _handleRadioValueChange,
                                                ),
                                              ],
                                            )),
                                      ),
                                      SizedBox(
                                        width: ScreenSize().getScreenWidth(1.5),
                                      ),
                                      Expanded(
                                        child: InputFeild(
                                          isOptional: false,
                                          isNum: false,
                                          icon: Icons.paid_outlined,
                                          inputLimit: 12,
                                          placeholder: 'Amount',
                                          inputFeild: () {},
                                          inputLabel: 'Amount',
                                          controller:
                                              controllers['transactionAmount'],
                                        ),
                                      ),
                                    ],
                                  ),
                                  _selectedValue == "Momo"
                                      ? InputFeild(
                                          isOptional: false,
                                          isNum: true,
                                          icon: Icons.phone_android,
                                          inputLimit: 12,
                                          placeholder: 'eg. TXN234354647',
                                          inputFeild: () {},
                                          inputLabel: 'Transaction ID',
                                          controller: controllers['walletID'],
                                        )
                                      : const SizedBox.shrink(),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Btn(
                                          btn: RED_COLOR,
                                          btnText: 'Cancel',
                                          btnAction: () {
                                            closeFunction();
                                          }
                                        ),
                                      ),
                                      SizedBox(
                                        width: ScreenSize().getScreenWidth(1.5),
                                      ),
                                      Expanded(
                                          child: Btn(
                                              btn: GREEN_COLOR,
                                              btnText: 'Submit',
                                              btnAction: () async {
                                                if (controllers[
                                                            "transactionAmount"] ==
                                                        null ||
                                                    controllers[
                                                            "transactionAmount"] ==
                                                        "") {
                                                  showCustomSnackBar(context,
                                                      "Transaction amount is required.",
                                                      isSuccess: false);
                                                  return; // Stop execution if required fields are missing
                                                }
                                                if (controllers[
                                                            "paymentMethod"] ==
                                                        null ||
                                                    controllers[
                                                            "paymentMethod"] ==
                                                        "") {
                                                  showCustomSnackBar(context,
                                                      "Payment method is required.",
                                                      isSuccess: false);
                                                  return; // Stop execution if required fields are missing
                                                }
                                                if (_selectedValue ==
                                                    null ||
                                                    _selectedValue ==
                                                        "") {
                                                  showCustomSnackBar(context,
                                                      "Please, Payment Method Is Required.",
                                                      isSuccess: false);
                                                  return; // Stop execution if required fields are missing
                                                }



                                                 store.setTransactionData(
                                                    context: context,
                                                    amount: controllers[
                                                            'transactionAmount']!
                                                        .text,
                                                    walletId:
                                                        controllers['walletID']!
                                                            .text,
                                                    transactionType:_selectedValue!,
                                                    deposit: _selectedDeposit!,
                                                    accountID: controllers[
                                                            "accountID"]!
                                                        .text);
                                                closeFunction();
                                              })),
                                    ],
                                  )
                                ],
                              ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  closeFunction(){

    setState(() {
      selectedUser = false;
      filteredUsers= {};
      controllers['firstName']?.text =
      '';
      controllers['middleName']?.text =
      '';
      controllers['lastName']?.text =
      '';
      controllers['accountID']?.text =
      '';
      controllers['location']?.text =
      '';
      controllers['contact']?.text = '';
      controllers['status']?.text = '';
    });

  }
}
