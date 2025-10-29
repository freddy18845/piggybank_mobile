import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Repository/transactions_DB.dart';
import '../constant.dart';
import '../utils/currency_format.dart';
import '../utils/screen_size.dart';
import '../utils/user_Manager.dart';
import '../utils/utils.dart';
import '../view_models/transaction_view_model.dart';
import '../widgets/date_picker_btn.dart';
import '../widgets/empty_table.dart';
import '../widgets/header.dart';
import '../widgets/inputFeild.dart';
import '../widgets/loader.dart';
import '../widgets/table.dart';


class BalanceAndStatementsScreen extends StatefulWidget {
  const BalanceAndStatementsScreen({super.key});

  @override
  State<BalanceAndStatementsScreen> createState() =>
      _BalanceAndStatementsScreenState();
}

class _BalanceAndStatementsScreenState
    extends State<BalanceAndStatementsScreen> {
  final TransactionsDBServices instanceTransaction = TransactionsDBServices();
  bool isLoading = false;
  Map<String, dynamic> filteredTransactions = {};
  Map<String, dynamic> totals = {};
  Map<String, dynamic> customerData = {};
  late List<DateTime>  selectedDates =[];
  final ScrollController _scrollController = ScrollController();
  static const int _pageSize = 15;
  int _currentMax = _pageSize;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final txnViewModel = context.read<TransactionViewModel>();
      txnViewModel.emptyFields();

    });
    setState(() {
      selectedDates =[];
    });
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent &&
        _currentMax < filteredTransactions.length) {
      setState(() {
        _currentMax =
            (_currentMax + _pageSize).clamp(0, filteredTransactions.length);
      });
    }
  }

  /// ✅ Helper function to compute totals


  /// ✅ Date range picker
  Future<void> pickDate(BuildContext context) async {
    final transactionStore = context.read<TransactionViewModel>();

    final List<DateTime?>? nullableDates = await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
        calendarType: CalendarDatePicker2Type.range,
        selectedDayHighlightColor: SECONDARY_COLOR,
        selectedRangeHighlightColor: SECONDARY_COLOR.withOpacity(0.3),
        calendarViewMode: CalendarDatePicker2Mode.scroll,
      ),
      dialogSize: const Size(250, 300),
      borderRadius: BorderRadius.circular(15),
    );

    if (nullableDates != null && nullableDates.isNotEmpty) {
       selectedDates =
      nullableDates.whereType<DateTime>().toList(growable: false);
      final userInfo = UserManager().getUserData();

      if (selectedDates.isNotEmpty) {
        transactionStore.searchControllers["startDate"]?.text =
            DateFormat('yyyy-MM-dd').format(selectedDates.first);
        transactionStore.searchControllers["endDate"]?.text =
            DateFormat('yyyy-MM-dd').format(selectedDates.length > 1
                ? selectedDates.last
                : selectedDates.first);

        setState(() => isLoading = true);

        await instanceTransaction.getCustomerStatement(
          userInfo.companyId,
          selectedDates.first,
          selectedDates.length > 1 ? selectedDates.last : selectedDates.first,
            transactionStore.searchControllers["accountID"]!.text
        );


        setState(() {
          filteredTransactions = transactionsStorage;
          totals = getTransactionTotals(filteredTransactions);
          if (filteredTransactions.isNotEmpty) {
            final firstKey = filteredTransactions.keys.first;
            customerData = filteredTransactions[firstKey];
          } else {
            customerData = {};
          }
          isLoading = false;
        });

      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  /// ✅ Customer filter
  void filterCustomers(String query) {
    if (query.isEmpty) {
      showCustomSnackBar(
        context,
        "Please Query Transactions First With Date Picker",
        isSuccess: false,
      );
      return;
    }

    setState(() {
      isLoading = true;
      filteredTransactions = Map.fromEntries(
        filteredTransactions.entries.where(
              (entry) => entry.value.values.any(
                (value) => value
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()),
          ),
        ),
      );
      totals = getTransactionTotals(filteredTransactions);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = ScreenSize().getScreenWidth(4);

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
          child: Consumer<TransactionViewModel>(
            builder: (context, store, child) {
              return Column(
                children: [
                  const Header(
                    showHome: false,
                    showPrevious: true,
                    showLogo: false,
                    selectedBtn: ' Customer Statement',
                    show2Nav: true,
                  ),
                  if (filteredTransactions.isEmpty)
                  Padding(
                  padding: EdgeInsets.symmetric(
                  horizontal: screenWidth,
                  ),
                  child:

                    Column(
                      children: [
                        SizedBox(height:ScreenSize().getScreenHeight(2) ,),
                         InputFeild(
                            isOptional: false,
                            isNum: false,
                            icon: Icons.search,
                            inputLimit: 2000,
                            placeholder: 'e.g. ASA1234556',
                            inputFeild: (value) => null,
                            inputLabel: 'Search By  ID',
                            controller:
                            store.searchControllers['accountID'] ??
                                TextEditingController(),
                          ),

                        Row(
                            children: [
                              dateButton(
                                date: store.searchControllers["startDate"]
                                    ?.text
                                    .isNotEmpty ==
                                    true
                                    ? DateFormat("dd-MMM-yyyy").format(
                                    DateTime.parse(store
                                        .searchControllers["startDate"]
                                        ?.text ??
                                        DateTime.now().toString()))
                                    : "Start Date",
                                onTap: () => pickDate(context),
                                isActive: store.searchControllers["startDate"]
                                    ?.text
                                    .isNotEmpty ==
                                    true,
                              ),
                              const Spacer(),
                              dateButton(
                                date: store.searchControllers["endDate"]
                                    ?.text
                                    .isNotEmpty ==
                                    true
                                    ? DateFormat("dd-MMM-yyyy").format(
                                    DateTime.parse(store
                                        .searchControllers["endDate"]
                                        ?.text ??
                                        DateTime.now().toString()))
                                    : "End Date",
                                onTap: () => pickDate(context),
                                isActive: store.searchControllers["endDate"]
                                    ?.text
                                    .isNotEmpty ==
                                    true,
                              ),
                            ],
                          ),



               if(isLoading)
               const Padding(
               padding: const EdgeInsets.only(top: 40),
              child:  Loader())

                      ],
                    ))
                  else
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth),
                        child: Column(
                          children: [
                            // ✅ Customer summary section
                            Container(
                              padding: const EdgeInsets.all(8),
                              margin:
                              const EdgeInsets.only(top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                color: PRIMARY_COLOR,
                                borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                                border: Border.all(
                                  color:
                                  SECONDARY_COLOR.withValues(alpha: 0.2),
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: SECONDARY_COLOR,
                                      borderRadius:
                                      const BorderRadius.all(Radius.circular(6)),
                                    ),
                                    child:  Text(
                                      (setCustomerName(
                                          customerData["customerId"] ??
                                              ""))
                                          .toUpperCase() ,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),

                                  Text(
                                    customerData["customerId"]?.toString() ??
                                        '',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10,
                                    ),
                                  ),
                                   Text(
                                     'Currency Balance '.toUpperCase(),
                                     style: const TextStyle(
                                       color: Colors.black,
                                       fontWeight: FontWeight.w900,
                                       fontSize: 8,
                                     ),
                                   ),
                                  const SizedBox(height: 6),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: 'GHS',
                                          style: TextStyle(
                                            color: SECONDARY_COLOR,
                                            fontWeight: FontWeight.w800,
                                            fontSize: 10,
                                          ),
                                        ),
                                        TextSpan(
                                          text: " ${Currency().format('${totals["accountBalance"] ?? 0.0}')}",
                                          style: const TextStyle(
                                            color: SECONDARY_COLOR,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const Divider(
                                    color: Colors.grey,
                                    thickness: 1.1,
                                  ),

                                  const SizedBox(height: 3),

                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 80,
                                            child: Text(
                                              'Savings:',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            Currency().format(
                                                '${totals["savings"] ?? 0.0}'),
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 80,
                                            child: Text(
                                              'Withdrawals:',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            Currency().format(
                                                '${totals["withdrawals"] ?? 0.0}'),
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 80,
                                            child: Text(
                                              'Loan Deposit:',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            Currency().format(
                                                '${totals["loans"] ?? 0.0}'),
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 80,
                                            child: Text(
                                              'Loans:',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            Currency().format(
                                                '${totals["loans_request"] ?? 0.0}'),
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Result ${filteredTransactions.length}',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    color: SECONDARY_COLOR,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),

                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      filteredTransactions ={};
                                      selectedDates =[];
                                    });
                                  },
                                  borderRadius: BorderRadius.circular(6),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.cancel_outlined,
                                        size: 20,

                                        color: Colors.red.withOpacity(0.7),
                                      ),
                                      const SizedBox(width: 5),
                                      const Text(
                                        'Cancel',
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          color: Colors.red,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 8),
                            buildTableHeader(),
                            Expanded(
                              child:filteredTransactions.isEmpty
                                  ? const Center(
                                  child: EmptyTable()
                              )
                                  : ListView.builder(
                                controller: _scrollController,
                                itemCount: _currentMax.clamp(0, filteredTransactions.length),
                                itemBuilder: (context, index) {
                                  final key = filteredTransactions.keys.elementAt(index);
                                  final data = filteredTransactions[key];
                                  if (data == null) return const SizedBox();
                                  return buildTableRow(data, index);
                                },
                              ),
                            ),
                            if (_currentMax < filteredTransactions.length)
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: SECONDARY_COLOR,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _currentMax = (_currentMax + _pageSize)
                                          .clamp(0, filteredTransactions.length);
                                    });
                                  },
                                  child: const Text(
                                    'Load More',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),

                          ],
                        ),
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
}
