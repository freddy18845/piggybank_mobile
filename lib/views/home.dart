import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:piggy_bank/utils/nav.dart';
import 'package:piggy_bank/view_models/store_view_model.dart';
import 'package:piggy_bank/views/add_customer_screen.dart';
import 'package:piggy_bank/views/customers_list_screen.dart';
import 'package:piggy_bank/views/transaction_history.dart';
import 'package:piggy_bank/views/withdrawal_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../Repository/customer_DB.dart';
import '../Repository/transactions_DB.dart';
import '../constant.dart';
import '../utils/currency_format.dart';
import '../utils/fonts_style.dart';
import '../utils/screen_size.dart';
import '../utils/user_Manager.dart';
import '../widgets/footer.dart';
import '../widgets/header.dart';
import '../widgets/home_card.dart';
import 'balance_and_statement_screen.dart';
import 'deposit_screen.dart';
import 'home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

bool isPressed = false;

class _HomeScreenState extends State<HomeScreen> {
  final TransactionsDBServices instanceTransaction = TransactionsDBServices();
  final CustomerDBServices instanceCM = CustomerDBServices();
  final TransactionsDBServices instanceTxn = TransactionsDBServices();
  bool isProcessing = false;

  Future<void> loadTransactionSFromDB() async {
    setState(() {
      isProcessing = true;
    });
    final userInfo = UserManager().getUserData();
    await instanceCM.getCustomers(userInfo.companyId);
    await instanceTxn.getTotalTransactionCount(userInfo.companyId);
    await instanceTxn.getTodayTransaction(userInfo.companyId);
    final storeViewModel = context.read<StoreViewModel>();
    storeViewModel.setDashboardData();

    setState(() {
      isProcessing = false;
    });
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadTransactionSFromDB();
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
          child: Column(
            children: [
              const Header(
                showHome: true,
                showPrevious: false,
                showLogo: false,
                selectedBtn: 'Daily Summary',
                show2Nav: true,
              ),
              Consumer<StoreViewModel>(
                builder: (context, store, child) {
                  return Column(
                    children: [
                      SizedBox(
                        height: ScreenSize().getScreenHeight(7),
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: ScreenSize().getScreenWidth(8),
                            vertical: ScreenSize().getScreenHeight(0.5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 1,
                                child: Container(
                                    width: ScreenSize().getScreenHeight(4)),
                              ),
                              Flexible(
                                flex: 2,
                                child: Text(
                                  "Total Sales",
                                  style: FontsStyle().headerSubTitle(),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    loadTransactionSFromDB();
                                  },
                                  child: Container(
                                    height: ScreenSize().getScreenHeight(4.5),
                                    width: ScreenSize().getScreenHeight(4.5),
                                    decoration: BoxDecoration(
                                      color: PRIMARY_COLOR,
                                      borderRadius: BorderRadius.circular(
                                        ScreenSize().getScreenHeight(2),
                                      ),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.refresh,
                                        color: isProcessing
                                            ? SECONDARY_COLOR.withOpacity(0.5)
                                            : SECONDARY_COLOR,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: ScreenSize().getScreenHeight(0.3)),
                          child: isProcessing
                              ? SizedBox(
                                  height: ScreenSize().getScreenHeight(7),
                                  child: CupertinoActivityIndicator(
                                    radius: 15,
                                    color:
                                        SECONDARY_COLOR, // Adjust the size of the spinner
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    AppNavigator.toHistory(context, true);
                                  },
                                  child: SizedBox(
                                    height: ScreenSize().getScreenHeight(7),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom: ScreenSize()
                                                  .getScreenHeight(0.5)),
                                          child: Text(
                                            "GH¢",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: ScreenSize()
                                                    .getScreenHeight(2),
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ),
                                        SizedBox(
                                            width:
                                                ScreenSize().getScreenWidth(1)),
                                        Text(
                                          Currency().format(
                                              '${store.totalDepositAmount}'),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: ScreenSize()
                                                  .getScreenHeight(5),
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                      Text(
                        "As At ${DateFormat("dd-MMM-yyyy  h:mm a").format(DateTime.now())}",
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: ScreenSize().getScreenWidth(2.5),
                          vertical: ScreenSize().getScreenHeight(2),
                        ),
                        child: Container(
                          height: ScreenSize().getScreenHeight(9),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/${IMAGES[3]}'),
                              fit: BoxFit.fill,
                            ),
                            borderRadius: BorderRadius.circular(
                              ScreenSize().getScreenHeight(1),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: ScreenSize().getScreenWidth(6),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  flex: 3,
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const CustomerListScreen()),
                                        );
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("Total Customers",
                                              style:
                                                  FontsStyle().homeCountTxt()),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: ScreenSize()
                                                    .getScreenHeight(0.3)),
                                            child: Text(
                                              isProcessing
                                                  ? "-"
                                                  : "${store.totalCustomers}",
                                              style: FontsStyle().homeCntText(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 0,
                                  child: SizedBox(
                                    height: ScreenSize().getScreenHeight(8),
                                    width: ScreenSize().getScreenWidth(2),
                                    child: const VerticalDivider(
                                      thickness: 1,
                                      color: Colors.white,
                                      indent: 3,
                                    ),
                                  ),
                                ),
                                Flexible(
                                    flex: 3,
                                    child: GestureDetector(
                                      onTap: () {
                                        AppNavigator.toHistory(context, true);
                                      },
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text("Transaction Count",
                                                style: FontsStyle()
                                                    .homeCountTxt()),
                                            Text(
                                              isProcessing
                                                  ? "-"
                                                  : "${store.transactionCount}",
                                              style: FontsStyle().homeCntText(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(
                height: ScreenSize().getScreenHeight(3),
              ),
              Text("Menu Items", style: FontsStyle().homeMenuTitle()),
              SizedBox(
                height: ScreenSize().getScreenHeight(2),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenSize().getScreenWidth(2.5)),
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  height: ScreenSize().getScreenHeight(32),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    // color: PRIMARY_COLOR,
                    borderRadius: BorderRadius.circular(
                      ScreenSize().getScreenHeight(1),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          HomeCard(
                            tapIcon: "assets/images/${ASSETS[5]}",
                            text: 'Deposit & Loans',
                            squareImage: false,
                            bottomDivider: true,
                            leftDivider: false,
                            rightDivider: true,
                            topDivider: false,
                            btnAction: () {
                             AppNavigator.toDeposit(context);
                            },
                          ),
                          HomeCard(
                            tapIcon: "assets/images/${ASSETS[3]}",
                            text: 'Mini Statement',
                            squareImage: false,
                            bottomDivider: true,
                            leftDivider: false,
                            rightDivider: false,
                            topDivider: false,
                            btnAction: () {
                              AppNavigator.toStatement(context);
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          HomeCard(
                            tapIcon: "assets/images/${IMAGES[5]}",
                            text: 'Withdrawal',
                            squareImage: false,
                            bottomDivider: false,
                            leftDivider: false,
                            rightDivider: true,
                            topDivider: false,
                            btnAction: () {
                             AppNavigator.toWithdrawal(context);
                            },
                          ),
                          HomeCard(
                            tapIcon: "assets/images/${ASSETS[4]}",
                            text: 'New Customer',
                            squareImage: false,
                            bottomDivider: false,
                            leftDivider: false,
                            rightDivider: false,
                            topDivider: false,
                            btnAction: () {
                              AppNavigator.toAddCustomer(context);
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.copyright,
                        size: ScreenSize().getScreenHeight(1),
                        color: Colors.black87,
                      ),
                      const SizedBox(
                        width: 1,
                      ),
                      Text(
                          "Copyright ${DateFormat.y().format(DateTime.now())} GoDigi Software Solutions. All Right Reserved",
                          style: FontsStyle().footercopyRight()),
                    ],
                  ),
                ),
              ),
              const Footer(
                btnIndex: 0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
