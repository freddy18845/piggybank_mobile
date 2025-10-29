

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:piggy_bank/view_models/sms_view_model.dart';
import '../constant.dart';
import '../utils/customer_manager.dart';
import '../utils/user_Manager.dart';
import '../utils/utils.dart';
import '../widgets/laoding_model.dart';

class TransactionsDBServices {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  /// ✅ Add Transaction with custom ID
  Future<void> addTransaction(
      BuildContext context,
      Map<String, dynamic> body,
      ) async {
    try {
      LoadingDailog.show(context);

      final String transactionID = _generateTransactionID(body['transactionType']);
      await firestore.collection(body['transactionType']).doc(transactionID).set(body);
      final smsService = SMSDBServices();
      final customerInfo = CustomerManager().getUserData();
      if (customerInfo.contact != "N/A") {
        await smsService.sendSMS(
          context: context,
          recipient: [customerInfo.contact!],
          message:
          "Dear ${customerInfo.firstName!} ${customerInfo.lastName!},\n"
              "Your ${body['transactionType']} transaction of GHS ${body['transactionAmount']} was successful!",
        );
      }

      CustomerManager().clear();
      Navigator.pop(context);
      showCustomSnackBar(
        context,
        "Customer ${body['transactionType']} Transaction Processed Successfully!",
        isSuccess: true,
      );
    } catch (e) {
      debugPrint("❌ Transaction failed: $e");
      Navigator.pop(context);
      showCustomSnackBar(
        context,
        "Customer ${body['transactionType']} Transaction Processing Failed!",
        isSuccess: false,
      );
    }
  }

  /// ✅ Generate a custom transaction ID (e.g., SAVINGS-20251010-0001)
  String _generateTransactionID(String type) {
    final date = DateFormat('yyyyMMdd').format(DateTime.now());
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString().substring(8);
    return "$type-$date-$timestamp";
  }

  /// ✅ Get a single customer’s transactions by date range

  Future<void> getCustomerStatement(
      String companyID,
      DateTime startDate,
      DateTime endDate,
      String customerID,
      ) async {
    try {
      transactionsStorage.clear();

      final List<String> collections = [
        "savings",
        "loans",
        "withdrawals",
        "loan_Requests",
      ];

      // Normalize date range
      final normalizedStart = DateTime(startDate.year, startDate.month, startDate.day, 0, 0, 0);
      final normalizedEnd = DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59);

      debugPrint("📅 Fetching statements from ${normalizedStart.toIso8601String()} to ${normalizedEnd.toIso8601String()}");
      debugPrint("🏢 Company: $companyID | 👤 Customer: $customerID");

      for (String collection in collections) {
        debugPrint("🔍 Searching collection: $collection");

        try {
          // ✅ Base query with date range
          Query query = firestore
              .collection(collection)
              .where('companyID', isEqualTo: companyID)
              .where('createDate', isGreaterThanOrEqualTo: Timestamp.fromDate(normalizedStart))
              .where('createDate', isLessThanOrEqualTo: Timestamp.fromDate(normalizedEnd))
              .orderBy('createDate', descending: true);

          // ✅ Apply customerId filter only if the collection uses it
          // (helps avoid empty results if some collections don't have this field)
          if (['savings', 'loans', 'withdrawals', 'loan_Requests'].contains(collection)) {
            query = query.where('customerId', isEqualTo: customerID.toString());
          }

          final querySnapshot = await query.get();

          debugPrint("📦 Found ${querySnapshot.docs.length} documents in $collection");

          for (var doc in querySnapshot.docs) {
            final data = doc.data();
            transactionsStorage['$collection-${doc.id}'] = data;
          }

          debugPrint("✅ Added ${querySnapshot.docs.length} records from $collection");
        } catch (e) {
          if (e.toString().contains('index') || e.toString().contains('FAILED_PRECONDITION')) {
            debugPrint("⚠️ MISSING COMPOSITE INDEX for $collection");
            debugPrint("📝 Error: $e");
            debugPrint("👆 Click the link above to create the index in Firebase Console");
            debugPrint("⏱️ Index creation takes 5–10 minutes");
          } else {
            debugPrint("❌ Error fetching from $collection: $e");
          }
        }
      }

      debugPrint("🎉 Total records fetched: ${transactionsStorage.length}");
    } catch (e) {
      debugPrint("❌ Error getting customer statement: $e");
      rethrow;
    }
  }






  /// ✅ Get all transactions across all staff (with role-based filter)
  Future<void> getAllTransaction(
      String companyID,
      DateTime startDate,
      DateTime endDate,
      ) async {
    try {
      transactionsStorage.clear();

      final userInfo = UserManager().getUserData();
      final normalizedStart = DateTime(startDate.year, startDate.month, startDate.day, 0, 0, 0);
      final normalizedEnd = DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59);

      final List<String> collections = [
        "savings",
        "loans",
        "withdrawals",
        "loan_Requests",
      ];

      debugPrint("📅 Fetching all transactions from ${normalizedStart.toIso8601String()} to ${normalizedEnd.toIso8601String()}");
      debugPrint("🏢 Company: $companyID | 👤 Role: ${userInfo.role}");

      for (String collection in collections) {
        debugPrint("🔍 Searching collection: $collection");

        try {
          Query query = firestore
              .collection(collection)
              .where('companyID', isEqualTo: companyID)
              .where('createDate', isGreaterThanOrEqualTo: Timestamp.fromDate(normalizedStart))
              .where('createDate', isLessThanOrEqualTo: Timestamp.fromDate(normalizedEnd))
              .orderBy('createDate', descending: false); // ✅ ascending order

          // 👤 Only filter by staffID for non-admin users
          if (userInfo.role != "Administrator") {
            query = query.where('staffID', isEqualTo: userInfo.staffId);
          }

          final querySnapshot = await query.get();

          debugPrint("📦 Found ${querySnapshot.docs.length} documents in $collection");

          for (var doc in querySnapshot.docs) {
            final data = doc.data() as Map<String, dynamic>?;
            if (data != null) {
              transactionsStorage['$collection-${doc.id}'] = data;
            }
          }

          debugPrint("✅ Added ${querySnapshot.docs.length} records from $collection");
        } catch (e) {
          if (e.toString().contains('index') || e.toString().contains('FAILED_PRECONDITION')) {
            debugPrint("⚠️ MISSING COMPOSITE INDEX for $collection");
            debugPrint("📝 Error: $e");
            debugPrint("👆 Click the link above to create the index in Firebase Console");
            debugPrint("⏱️ Index creation takes 5–10 minutes");
          } else {
            debugPrint("❌ Error fetching from $collection: $e");
          }
        }
      }

      debugPrint("🎉 Total records fetched: ${transactionsStorage.length}");
    } catch (e) {
      debugPrint("❌ Error fetching all transactions: $e");
      rethrow;
    }
  }


  /// ✅ Get today's transactions only
  Future<void> getTodayTransaction(String companyID) async {
    try {
      transactionsStorage.clear();

      final userInfo = UserManager().getUserData();
      final now = DateTime.now();
      final startOfDay = DateTime(now.year, now.month, now.day, 0, 0, 0);
      final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);

      final List<String> collections = ["savings", "loans"];

      for (String collection in collections) {
        Query query = firestore
            .collection(collection)
            .where('companyID', isEqualTo: companyID)
            .where('createDate', isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
            .where('createDate', isLessThanOrEqualTo: Timestamp.fromDate(endOfDay));

        if (userInfo.role != "Administrator") {
          query = query.where('staffID', isEqualTo: userInfo.staffId);
        }

        final querySnapshot = await query.get();

        for (var doc in querySnapshot.docs) {
          final data = doc.data() as Map<String, dynamic>?;
          if (data != null) {
            transactionsStorage['$collection-${doc.id}'] = data;
          }
        }
      }
    } catch (e, stack) {
      debugPrint('❌ Error fetching today’s transactions: $e');
      debugPrint('📄 Stack trace: $stack');
    }
  }

  /// ✅ Delete Transaction
  Future<void> deleteTransaction(BuildContext context, String collection, String documentId) async {
    try {
      await firestore.collection(collection).doc(documentId).delete();
      showCustomSnackBar(context, "Transaction Deleted Successfully!", isSuccess: true);
    } catch (e) {
      showCustomSnackBar(context, "Transaction Deletion Failed!", isSuccess: false);
      debugPrint('❌ Error deleting transaction: $e');
    }
  }

  /// ✅ Get total transaction count and amounts for today
  Future<void> getTotalTransactionCount(String companyID) async {
    try {
      transactionsStorage.clear();
      double totalSavings = 0.0;
      double totalLoans = 0.0;

      final now = DateTime.now();
      final startOfDay = DateTime(now.year, now.month, now.day);
      final endOfDay = startOfDay.add(const Duration(days: 1));

      final List<String> collections = ["savings", "loans"];

      for (String collection in collections) {
        try {
          final querySnapshot = await firestore
              .collection(collection)
              .where('companyID', isEqualTo: companyID)
              .where('createDate', isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
              .where('createDate', isLessThanOrEqualTo: Timestamp.fromDate(endOfDay))
              .get();

          for (var doc in querySnapshot.docs) {
            final data = doc.data() as Map<String, dynamic>?;
            if (data == null) continue;

            transactionsStorage['$collection-${doc.id}'] = data;
            final double amount = (data['amount'] ?? 0).toDouble();

            if (collection == "savings") {
              totalSavings += amount;
            } else if (collection == "loans") {
              totalLoans += amount;
            }
          }
        } catch (e) {
          debugPrint("⚠️ Fallback for missing Firestore index in $collection: $e");
        }
      }

      totalDepositAmount = totalSavings + totalLoans;
      debugPrint("💰 Total Savings: $totalSavings");
      debugPrint("🏦 Total Loans: $totalLoans");
    } catch (e) {
      debugPrint("❌ Error fetching total transactions: $e");
    }
  }
}
