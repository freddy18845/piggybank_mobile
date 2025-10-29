import 'package:flutter/material.dart';
import 'package:piggy_bank/constant.dart';
import 'package:piggy_bank/utils/screen_size.dart';
import 'package:piggy_bank/widgets/button.dart';

import '../utils/utils.dart';

class FilterTransactionDialog extends StatefulWidget {
  final Map<String, dynamic> allTransactions;

  const FilterTransactionDialog({
    Key? key,
    required this.allTransactions,
  }) : super(key: key);

  /// ✅ Opens the dialog and returns the filtered map
  static Future<Map<String, dynamic>?> show(
      BuildContext context,
      Map<String, dynamic> allTransactions,
      ) async {
    return await showDialog<Map<String, dynamic>>(
      context: context,
      barrierDismissible: false,
      builder: (_) => FilterTransactionDialog(
        allTransactions: allTransactions,
      ),
    );
  }

  @override
  State<FilterTransactionDialog> createState() =>
      _FilterTransactionDialogState();
}

class _FilterTransactionDialogState extends State<FilterTransactionDialog> {
  bool isProcessing = false;

  /// ✅ Define your available transaction types (collections)
  final List<String> collections = [
    "savings",
    "loans",
    "withdrawals",
    "loan_Requests",
  ];

  /// ✅ Track which filters are selected
  final Map<String, bool> selectedCollections = {};

  @override
  void initState() {
    super.initState();
    for (final col in collections) {
      selectedCollections[col] = false;
    }
  }

  /// ✅ Filter logic based on selected collections
  Map<String, dynamic> _applyFilters() {
    if (selectedCollections.values.every((selected) => !selected)) {
      // If nothing selected, return all transactions
      return widget.allTransactions;
    }
    if ( widget.allTransactions.isNotEmpty) {
      showCustomSnackBar(
        context,
        "Sorry Transaction Storage Is Empty",
        isSuccess: false,
      );
      return widget.allTransactions;
    }

    Map<String, dynamic> result = {};
    widget.allTransactions.forEach((key, transaction) {
      for (final collection in selectedCollections.keys) {
        if (selectedCollections[collection] == true &&
            key.startsWith(collection)) {
          result[key] = transaction;
          break;
        }
      }
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.topCenter,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.only(top: ScreenSize().getScreenHeight(20)),
      content: Container(
        height: ScreenSize().getScreenHeight(41),
        width: ScreenSize().getScreenWidth(85),
        padding: EdgeInsets.symmetric(
          vertical: ScreenSize().getScreenHeight(2),
          horizontal: ScreenSize().getScreenWidth(4),
        ),
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Filter Transactions",
                style: TextStyle(
                  fontSize: ScreenSize().getScreenHeight(1.8),
                  fontWeight: FontWeight.bold,
                  color: SECONDARY_COLOR,
                ),
              ),
            ),
            const Divider(thickness: 1,),

            /// ✅ Filter options
            Expanded(
              child: ListView(
                children: collections.map((collection) {
                  return CheckboxListTile(
                    value: selectedCollections[collection],
                    title: Text(
                      collection.toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    activeColor: Colors.green,
                    onChanged: (value) {
                      setState(() {
                        selectedCollections[collection] = value ?? false;
                      });
                    },
                  );
                }).toList(),
              ),
            ),

            const Divider(thickness: 1),
            Row(
              children: [
                Expanded(
                  child: Btn(
                    btn: RED_COLOR,
                    btnText: 'Cancel',
                    btnAction: () => Navigator.pop(context),
                  ),
                ),
                SizedBox(width: ScreenSize().getScreenWidth(4)),
                Expanded(
                  child: Btn(
                    btn: SECONDARY_COLOR,
                    btnText: isProcessing ? 'Filtering...' : 'Apply',
                    btnAction: () async {
                      setState(() => isProcessing = true);

                      final filtered = _applyFilters();

                      await Future.delayed(const Duration(milliseconds: 300));
                      if (mounted) {
                        Navigator.pop(context, filtered);
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
