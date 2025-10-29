// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:piggy_bank/view_models/sms_view_model.dart';
// import '../constant.dart';
// import '../utils/company_Manager.dart';
// import '../utils/user_Manager.dart';
// import '../utils/utils.dart';
//
// class CustomerDBServices {
//
//   // Reference to the Firestore instance
//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//   SMSDBServices smsInstance = SMSDBServices();
//   // Add a new Customer document to the 'users' collection
//   createCustomer(BuildContext context, Map<String, dynamic> body) async {
//     final companyData= CompanyManager().getCompanyData();
//     try {
//       await firestore.collection('customers').add(body);
//       await smsInstance.sendSMS(
//         // replace with your approved sender ID
//         context: context,
//         recipient:[ body["contact"]], // recipient phone number
//         message: "Hello ${body["firstName"]},\n Welcome To  ${companyData.name}!. "
//             " Please Contact ${companyData.phone} For More Info. ",
//       );
//
//       // if (success) {
//       //   print("Message delivered ✅");
//       // } else {
//       //   print("Message Failed!");
//       // }
//       Navigator.pop(context);
//       showCustomSnackBar(context, "Customer Added Successfully!",
//           isSuccess: true);
//     } catch (e) {
//       Navigator.pop(context);
//       showCustomSnackBar(context, "Customer  Data Addition   Failed!",
//           isSuccess: false);
//     }
//   }
//
//
//
//   // Add a get all Company user document to the 'users' collection
//   Future<void> getCustomers(String companyID) async {
//     //debugPrint('Fetching customers started');
//     try {
//       final userInfo = UserManager().getUserData();
//       QuerySnapshot querySnapshot;
//       // Query the 'customers' collection where 'companyID' matches 'AS123'
//       if(userInfo.role == "Administrator"){
//         querySnapshot = await FirebaseFirestore.instance
//             .collection('customers')
//             .where('companyID', isEqualTo: companyID) // Filter by status
//             .get();
//       }else{
//         querySnapshot = await FirebaseFirestore.instance
//             .collection('customers')
//             .where('companyID', isEqualTo: companyID)
//             .where('staffID', isEqualTo: userInfo.staffId) // Filter by status
//             .get();
//       }
//
//       // Clear the storage to avoid duplicate entries
//       customersStorage.clear();
//
//       // Process each document
//       for (var doc in querySnapshot.docs) {
//         String documentId = doc.id;
//
//         // Ensure data is a non-null map before processing
//         Map<String, dynamic>? customersData =
//             doc.data() as Map<String, dynamic>?;
//         if (customersData != null) {
//           // Add the document ID to the data map
//           customersData['documentId'] = documentId;
//
//           // Add the data to the storage
//           customersStorage[documentId] = customersData;
//           totalCustomers = customersStorage[documentId].length;
//
//         } else {
//           debugPrint('Null data found in document: $documentId');
//         }
//       }
//
//       // debugPrint('All customers processed: $customersStorage');
//     } catch (e) {
//       debugPrint('Error getting customers: $e');
//     }
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:piggy_bank/view_models/sms_view_model.dart';
import '../constant.dart';
import '../utils/company_Manager.dart';
import '../utils/user_Manager.dart';
import '../utils/utils.dart';

class CustomerDBServices {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final SMSDBServices smsInstance = SMSDBServices();

  // 🔹 CREATE CUSTOMER (with your own custom customerID)
  Future<void> createCustomer(BuildContext context, Map<String, dynamic> body) async {
    try {
      // Use your unique customer ID (could be generated beforehand)
      final String customerID = body["customerID"];
      final companyData = CompanyManager().getCompanyData();

      await firestore.collection('customers').doc(customerID).set(body);

      // Send welcome SMS
      await smsInstance.sendSMS(
        context: context,
        recipient: [body["contact"]],
        message:
        "Hello ${body["firstName"]},\nWelcome to ${companyData.name}! "
            "Please contact ${companyData.phone} for more info.",
      );

      Navigator.pop(context);
      showCustomSnackBar(context, "Customer Added Successfully!", isSuccess: true);
    } catch (e) {
      Navigator.pop(context);
      showCustomSnackBar(context, "Customer Data Addition Failed!", isSuccess: false);
    }
  }

  // 🔹 GET CUSTOMERS (filtered by companyID and optionally staffID)
  Future<void> getCustomers(String companyID) async {
    try {
      final userInfo = UserManager().getUserData();
      QuerySnapshot querySnapshot;

      if (userInfo.role == "Administrator") {
        querySnapshot = await firestore
            .collection('customers')
            .where('companyID', isEqualTo: companyID)
            .get();
      } else {
        querySnapshot = await firestore
            .collection('customers')
            .where('companyID', isEqualTo: companyID)
            .where('staffID', isEqualTo: userInfo.staffId)
            .get();
      }

      // Clear storage to avoid duplicates
      customersStorage.clear();

      for (var doc in querySnapshot.docs) {
        final Map<String, dynamic>? customerData =
        doc.data() as Map<String, dynamic>?;
        if (customerData != null) {
          customerData['documentId'] = doc.id;
          customersStorage[doc.id] = customerData;
        }
      }

      totalCustomers = customersStorage.length;

    } catch (e) {
      debugPrint('Error getting customers: $e');
    }
  }
}
