import 'package:intl/intl.dart';
import 'package:piggy_bank/view_models/deposit_view_model.dart';
import 'package:piggy_bank/widgets/button.dart';
import 'package:piggy_bank/widgets/inputFeild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constant.dart';
import '../models/customerData.dart';
import '../utils/customer_manager.dart';
import '../utils/fonts_style.dart';
import '../utils/screen_size.dart';
import '../utils/utils.dart';
import '../widgets/header.dart';
import '../widgets/transaction_card.dart';

class WithdrawalScreen extends StatefulWidget {
  const WithdrawalScreen({super.key});

  @override
  State<WithdrawalScreen> createState() => _WithdrawalScreenState();
}

class _WithdrawalScreenState extends State<WithdrawalScreen> {

  bool selectedUser= false;
  Map <String, dynamic> filteredUsers = {};
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


  void filterCustomers(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredUsers = {};
        selectedUser = false;
      });
      return;
    }

    setState(() {
      filteredUsers = Map.fromEntries(
        customersStorage.entries.where(
              (entry) => entry.value.values.any(
                (value) => value
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()),
          ),
        ),
      );
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
                      image: AssetImage(
                        'assets/images/${IMAGES[2]}',
                      ),
                      fit: BoxFit.fill)),
              child:Consumer<DepositViewModel>(
                  builder: (context, store, child) {
                    return
                      Column(
                        children: [
                          const Header(
                            showHome: false,
                            showPrevious: true,
                            showLogo: false,
                            selectedBtn: 'Deposit(Savings Or Loans) ',
                            show2Nav: true,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: ScreenSize().getScreenHeight(0.8)),
                            child: Text(
                              "Search By Account ID or Last Name",
                              style: FontsStyle().subTitleTwo(),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: ScreenSize().getScreenWidth(6)),
                            child: Column(
                              children: [

                                SizedBox(height: 15,),
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
                                  height: ScreenSize().getScreenHeight(55),
                                  child: ListView.builder(
                                    itemCount: filteredUsers.length,
                                    itemBuilder: (context, index) {
                                      final listItem =
                                      filteredUsers.values.toList()[index];
                                      return TransactionCard(
                                        fullName:
                                        "${listItem["firstName"]} ${listItem["middleName"] ?? ""} ${listItem["lastName"]}",
                                        accountID: listItem["customerId"] ?? '',
                                        status:listItem["status"] ,
                                        action: () {
                                          setState(() {
                                            selectedUser = true;
                                            controllers['firstName']?.text = listItem['firstName'] ?? '';
                                            controllers['middleName']?.text = listItem['middleName'] ?? '';
                                            controllers['lastName']?.text = listItem['lastName'] ?? '';
                                            controllers['accountID']?.text = listItem["customerId"] ?? '';
                                            controllers['location']?.text = listItem['location'] ?? '';
                                            controllers['contact']?.text = listItem['contact'] ?? '';
                                            controllers['status']?.text = listItem['status'] ?? '';
                                          });
                                          CustomerManager().setCustomerData(data:
                                          CustomerData(
                                              firstName: listItem["firstName"],
                                              middleName: listItem["middleName"],
                                              lastName: listItem["lastName"],
                                              location: listItem["location"],
                                              customerId: listItem["customerId"],
                                              contact: listItem["contact"]
                                          ));
                                        },
                                      );
                                    },
                                  ),
                                ):
                                Column(children: [
                                  TransactionCard(
                                    fullName:
                                    "${controllers["firstName"]?.text ?? ''} ${controllers["middleName"]!.text ?? ''} ${controllers["lastName"]!.text ?? ''}",
                                    accountID:
                                    controllers["accountID"]!.text,
                                    action: () {},
                                    status: controllers['status']!.text,
                                  ),
                                  SizedBox(height: ScreenSize().getScreenHeight(2.5)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      Expanded(
                                        child: InputFeild(
                                            isOptional: false,
                                            isNum: false,
                                            icon: Icons.paid_outlined,
                                            inputLimit: 12,
                                            placeholder: 'Amount',
                                            inputFeild: () {},
                                            inputLabel: 'Amount',
                                            controller:controllers['transactionAmount']
                                        ),
                                      ),
                                    ],
                                  ),

                                  Row(
                                    children: [
                                      Expanded(
                                        child: Btn(
                                          btn: RED_COLOR,
                                          btnText: 'Cancel',
                                          btnAction: () {
                                            closeFunction();
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: ScreenSize().getScreenWidth(1.5),
                                      ),
                                      Expanded(
                                        child: Btn(
                                          btn: GREEN_COLOR,
                                          btnText: 'Submit',
                                          btnAction: () {

                                            if(controllers['transactionAmount']!.text.isNotEmpty ){
                                              store.setWithdrawalData(context: context, amount: controllers['transactionAmount']!.text, accountID: controllers["accountID"]!.text);
                                            }else{
                                              showCustomSnackBar(context, "All fields is required.",
                                                  isSuccess: false);
                                            }

                                            closeFunction();
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                ],)
                              ],
                            ),
                          )
                        ],
                      );})
          )),
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
