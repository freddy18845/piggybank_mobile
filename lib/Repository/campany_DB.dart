import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:piggy_bank/utils/company_Manager.dart';
import '../constant.dart';
import '../models/companyData.dart';
import '../utils/utils.dart';


class CampanyDBService  {
  // Reference to the Firestore instance
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Add a new user document to the 'users' collection
  // createCompany(BuildContext context, Map <String, dynamic> body) async {
  //   try {
  //
  //     await firestore.collection('company').add(body);
  //     Navigator.pop(context);
  //     showCustomSnackBar(context, "Company Added Successfully!", isSuccess: true);
  //
  //   } catch (e) {
  //     Navigator.pop(context);
  //     showCustomSnackBar(context, "Company  Data Addition   Failed!", isSuccess: false);
  //
  //   }
  // }
  Future<void> createCompany(BuildContext context, Map<String, dynamic> body) async {
    try {
      final companyID = body['companyID'];

      if (companyID == null || companyID.isEmpty) {
        showCustomSnackBar(context, "Missing companyID!", isSuccess: false);
        return;
      }

      await FirebaseFirestore.instance
          .collection('company')
          .doc(companyID) // ✅ use your companyID as the Firestore doc ID
          .set(body);

      Navigator.pop(context);
      showCustomSnackBar(context, "Company Added Successfully!", isSuccess: true);

    } catch (e) {
      Navigator.pop(context);
      showCustomSnackBar(context, "Company Data Addition Failed!", isSuccess: false);
    }
  }



  Future<void> getCompany(String companyId) async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('company')
          .doc(companyId)
          .get();

      if (!doc.exists) {
        debugPrint('⚠️ No company found with ID: $companyId');
        return;
      }

      final companyData = doc.data() as Map<String, dynamic>;
      companyData['documentId'] = doc.id;

      CompanyManager().setCompanyData(
        name: companyData["name"] ?? '',
        phone: companyData["phone"] ?? '',
        companyId: companyData["companyId"] ?? '',
        registrationId: companyData["registrationId"] ?? '',
        otherPhone: companyData["otherPhone"] ?? '',
        location: companyData["location"] ?? '',
        email: companyData["email"] ?? '',
        status: companyData["status"] ?? '',
        senderId: companyData["senderId"] ?? '',
        smsCount: companyData["smsCount"] ?? '',
        appLogo: companyData["appLogo"]?? "",
        subscriptionEndDate: companyData["subscriptionEndDate"] ?? '',
      );

      debugPrint('✅ Company data loaded successfully.');

    } catch (e, stackTrace) {
      debugPrint('❌ Error getting company: $e');
      debugPrint(stackTrace.toString());
    }
  }

  // Add a get all Company user document to the 'users' collection
  // Future<void> getCompany(String companyId) async {
  //   try {
  //     final querySnapshot = await FirebaseFirestore.instance
  //         .collection('company')
  //         .where('companyId', isEqualTo: companyId) // ✅ consistent casing
  //         .limit(1)
  //         .get();
  //
  //     if (querySnapshot.docs.isEmpty) {
  //       debugPrint('No company found with ID: $companyId');
  //       return;
  //     }
  //
  //     final doc = querySnapshot.docs.first;
  //     final companyData = doc.data() as Map<String, dynamic>;
  //
  //     companyData['documentId'] = doc.id;
  //
  //     // ✅ Safely extract values with null-aware operators
  //     CompanyManager().setCompanyData(
  //       name: companyData["name"] ?? '',
  //       phone: companyData["phone"] ?? '',
  //       companyId: companyData["companyId"] ?? '',
  //       registrationId: companyData["registrationId"] ?? '',
  //       otherPhone: companyData["otherPhone"] ?? '',
  //       location: companyData["location"] ?? '',
  //       email: companyData["email"] ?? '',
  //       status: companyData["status"] ?? '',
  //       senderId: companyData["senderId"] ?? '',
  //       smsCount: companyData["smsCount"] ?? '',
  //       subscriptionEndDate: companyData["subscriptionEndDate"] ?? '',
  //     );
  //
  //     debugPrint('Company data loaded successfully.');
  //
  //   } catch (e, stackTrace) {
  //     debugPrint('❌ Error getting company: $e');
  //     debugPrint(stackTrace.toString());
  //   }
  // }



  Future<void> updateCompanySMS(BuildContext context, String companyID) async {
    final companyRef = FirebaseFirestore.instance.collection('company').doc(companyID);
    final snapshot = await companyRef.get();

    if (!snapshot.exists) {
      debugPrint("⚠️ No company found for ID: $companyID");
      return;
    }

    final data = snapshot.data()!;
    final currentSmsCount = int.tryParse(data['smsCount'].toString()) ?? 0;
    final newSmsCount = (currentSmsCount - 1).clamp(0, currentSmsCount);

    await companyRef.update({'smsCount': newSmsCount.toString()});

    debugPrint("✅ Company SMS count updated to $newSmsCount");
  }




  // Update a particular  User from 'users' collection
  // Future<void> updateCompanySMS(
  //     BuildContext context,
  //     String companyID,
  //     ) async {
  //
  //     // 🔹 Query company by companyID
  //     final querySnapshot = await FirebaseFirestore.instance
  //         .collection('company')
  //         .where('companyID', isEqualTo: companyID)
  //         .limit(1)
  //         .get();
  //
  //     if (querySnapshot.docs.isEmpty) {
  //       debugPrint("⚠️ No company found for ID: $companyID");
  //       return;
  //     }
  //
  //     final doc = querySnapshot.docs.first;
  //     final companyRef = doc.reference;
  //
  //     // 🔹 Get current data
  //     final currentData = doc.data();
  //     final currentSmsCount = (currentData['smsCount'] ?? 0) as int;
  //
  //     // 🔹 Subtract 1 safely (no negative values)
  //     final newSmsCount = (currentSmsCount - 1).clamp(0, currentSmsCount);
  //
  //     // 🔹 Update Firestore document
  //     await companyRef.update({'smsCount': newSmsCount.toString()});
  //
  //     debugPrint("✅ Company SMS count updated to $newSmsCount");
  //
  // }




// Delete a particular  User from 'users' collection

}
