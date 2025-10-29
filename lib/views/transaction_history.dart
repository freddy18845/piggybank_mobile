import 'dart:async';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:intl/intl.dart';
import 'package:piggy_bank/widgets/inputFeild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Repository/transactions_DB.dart';
import '../constant.dart';
import '../utils/screen_size.dart';
import '../utils/user_Manager.dart';
import '../utils/utils.dart';
import '../view_models/transaction_view_model.dart';
import '../widgets/date_picker_btn.dart';
import '../widgets/divider.dart';
import '../widgets/empty_table.dart';
import '../widgets/filter_transaction_model.dart';
import '../widgets/footer.dart';
import '../widgets/header.dart';
import '../widgets/loader.dart';
import '../widgets/table.dart';

class TransactionHistoryScreen extends StatefulWidget {
 final  bool isTodayTransaction;
  const TransactionHistoryScreen({super.key,
     this.isTodayTransaction = false});

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  bool isLoading = false;
  Map<String, dynamic> filteredTransactions = {};

  final TransactionsDBServices instanceTransaction = TransactionsDBServices();

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
      if(widget.isTodayTransaction){
        filteredTransactions = transactionsStorage;
      }

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


  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  Future<void> pickDate(BuildContext context) async {
    final transactionStore = context.read<TransactionViewModel>();

    final List<DateTime?>? nullableDates = await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
        calendarType: CalendarDatePicker2Type.range,
        selectedDayHighlightColor: SECONDARY_COLOR,
        selectedRangeHighlightColor: SECONDARY_COLOR.withOpacity(0.3),
        calendarViewMode: CalendarDatePicker2Mode.scroll,
        dayTextStyle:
            const TextStyle(color: Colors.black, fontFamily: 'Roboto'),
        selectedDayTextStyle: const TextStyle(
          color: Colors.white,
          fontFamily: 'Gilroy',
          fontWeight: FontWeight.bold,
        ),
      ),
      dialogSize: const Size(250, 300),
      borderRadius: BorderRadius.circular(15),
    );

    // Handle null case and convert to non-nullable list
    if (nullableDates != null && nullableDates.isNotEmpty) {
      // Filter out null values and convert to non-nullable List<DateTime>
      final List<DateTime> selectedDates =
          nullableDates.where((date) => date != null).cast<DateTime>().toList();
      final userInfo = UserManager().getUserData();
      if (selectedDates.isNotEmpty) {
        setState(() {
          transactionStore.searchControllers["startDate"]!.text =
              DateFormat('yyyy-MM-dd HH:mm:ss').format(
                  selectedDates.first.copyWith(hour: 0, minute: 0, second: 0));
          transactionStore.searchControllers["endDate"]!.text =
              DateFormat('yyyy-MM-dd HH:mm:ss').format((selectedDates.length > 1
                      ? selectedDates.last
                      : selectedDates.first)
                  .copyWith(hour: 23, minute: 59, second: 59));
        });
        if (selectedDates.first == null || selectedDates.last == null) {
          debugPrint("⚠️ Invalid date range entered.");
          return;
        }
        if (transactionStore.searchControllers["startDate"]!.text.isNotEmpty ||
            transactionStore.searchControllers["startDate"]!.text != null) {

          transactionStore.searchControllers["startDate"]!.text = DateFormat('yyyy-MM-dd').format(selectedDates.first);
          transactionStore.searchControllers["endDate"]!.text= DateFormat('yyyy-MM-dd').format(selectedDates.last);
// ✅ Fetch transactions
          setState(() => isLoading = true);
  await instanceTransaction.getAllTransaction(
    userInfo.companyId,
    selectedDates.first,
    selectedDates.last,
  );

  // ✅ Trigger rebuild after fetch
  setState(() {
    filteredTransactions = transactionsStorage;
    isLoading = false;
  });

        } else {
          showCustomSnackBar(
            context,
            "Please, Enter Customer ID",
            isSuccess: false,
          );
        }
      }
    }
  }

  void filterCustomers(String query) {
    setState(() => isLoading = true);
    if (query.isEmpty) {
      showCustomSnackBar(
        context,
        "Please Query Transactions First With Date Picker",
        isSuccess: false,
      );
      return;
    }

    setState(() {

      filteredTransactions = Map.fromEntries(
        customersStorage.entries.where(
              (entry) => entry.value.values.any(
                (value) =>
                value.toString().toLowerCase().contains(query.toLowerCase()),
          ),
        ),
      );
    });
    setState(() => isLoading = false);
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
                    selectedBtn: ' Transactions History',
                    show2Nav: true,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth,
                        vertical: ScreenSize().getScreenHeight(1.5)),
                    child: Row(
                      children: [
                        dateButton(
                          date: store.searchControllers["startDate"]!.text
                                  .isNotEmpty
                              ? DateFormat("dd-MMM-yyyy").format(DateTime.parse(
                                  store.searchControllers["startDate"]!.text))
                              : "Start Date",
                          onTap: () => pickDate(context),
                          isActive: store.searchControllers["startDate"]!.text
                                  .isNotEmpty
                              ? true
                              : false,
                        ),
                        Expanded(flex: 1, child: Container()),
                        dateButton(
                          date: store
                                  .searchControllers["endDate"]!.text.isNotEmpty
                              ? DateFormat("dd-MMM-yyyy").format(DateTime.parse(
                                  store.searchControllers["endDate"]!.text))
                              : "End Date",
                          onTap: () => pickDate(context),
                          isActive: store
                                  .searchControllers["endDate"]!.text.isNotEmpty
                              ? true
                              : false,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth),
                    child: InputFeild(
                      isOptional: false,
                      isNum: false,
                      icon: Icons.search,
                      inputLimit: 200,
                      placeholder: 'e.g. ASA1234556',
                      inputFeild: (value) => filterCustomers(value),
                      inputLabel: 'By Account ID or Name',
                      controller: store.searchControllers['accountID'],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Result ${filteredTransactions.length}',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            color: SECONDARY_COLOR,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            setState(() => isLoading = true);
                            final filtered = await FilterTransactionDialog.show(
                              context,
                              filteredTransactions,
                            );

                            if (filtered != null) {
                              setState(() {
                                filteredTransactions = filtered;
                              });
                            }
                            setState(() => isLoading = false);
                          },
                          borderRadius: BorderRadius.circular(6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.filter_list,
                                size: 20,
                                color: SECONDARY_COLOR.withOpacity(0.7),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                'Filter',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: SECONDARY_COLOR,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                       SizedBox(
                          height: ScreenSize().getScreenHeight(1.5),
                        ),

                  FadedDivider(),
                  SizedBox(height: ScreenSize().getScreenHeight(1)),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth),
                      child: Column(
                        children: [
                          // ✅ Customer summary section


                          const SizedBox(height: 8),
                          buildTableHeader(),
                          isLoading?Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Loader(),):

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
                                return  buildTableRow(data, index);
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
                  const Footer(
                    btnIndex: 1,
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
