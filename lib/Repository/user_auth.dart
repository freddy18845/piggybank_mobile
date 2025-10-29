// import 'dart:async';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../utils/company_Manager.dart';
// import '../utils/user_Manager.dart';
// import '../utils/utils.dart';
// import '../view_models/store_view_model.dart';
// import '../views/home.dart';
// import 'campany_DB.dart';
//
//
// class UserAuth {
//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//   final CampanyDBService instanceCM = CampanyDBService();
//   Future<void> signInUser(BuildContext context, String userID, String password) async {
//     try {
//       // Start login process
//       final storeVM = Provider.of<StoreViewModel>(context, listen: false);
//
//       // Query Firestore for matching user credentials
//       final querySnapshot = await FirebaseFirestore.instance
//           .collection('users')
//           .where('StaffID', isEqualTo: userID)
//           .where('password', isEqualTo: password)
//           .get()
//           .timeout(
//         const Duration(seconds: 10),
//         onTimeout: () => throw TimeoutException("Login request timed out. Please try again."),
//       );
//
//       // Validate login credentials
//       if (querySnapshot.docs.isEmpty) {
//         showCustomSnackBar(context, "Login Failed: Invalid credentials!", isSuccess: false);
//         storeVM.disableLoader();
//         return;
//       }
//
//       final userDoc = querySnapshot.docs.first;
//       final userData = userDoc.data() as Map<String, dynamic>;
//       //final String companyId = userData["companyID"];
//       final String companyId = userData["companyID"].toString();
//       if (companyId == null) {
//         showCustomSnackBar(context, "Invalid company ID format!", isSuccess: false);
//         storeVM.disableLoader();
//         return;
//       }
//      // Fetch company details
//       final companySnapshot = await FirebaseFirestore.instance
//           .collection('company')
//           .where('companyId', isEqualTo: companyId)
//           .limit(1)
//           .get();
//
//
//       if (companySnapshot.docs.isEmpty) {
//         showCustomSnackBar(context, "Login Failed: Company not found!", isSuccess: false);
//         storeVM.disableLoader();
//         return;
//       }
//
//       final companyData = companySnapshot.docs.first.data();
//
//       // ✅ Check if company is approved
//       if ((companyData["status"] ?? "").toString() != "Approved") {
//         showCustomSnackBar(
//           context,
//           "Login Failed: Company not${companyData["status"]}",
//           isSuccess: false,
//         );
//         storeVM.disableLoader();
//         return;
//       }
//       final currentData = DateTime.now();
//       if(companyData["subscriptionEndDate"]!=null){
//         if (DateTime.tryParse((companyData["subscriptionEndDate"] ?? ""))!.isBefore(currentData)) {
//           showCustomSnackBar(
//             context,
//             "Company Subscription Expired, Contact PiggyBank Account Office.",
//             isSuccess: false,
//           );
//
//           return;
//         }
//         final difference = currentData.difference((companyData["subscriptionEndDate"] ?? "")).inDays;
//         if (difference >= 0 && difference <= 7) {
//           showCustomSnackBar(
//             context,
//             "Company Subscription Is Almost Due, Kingly Renew Before the Due Date.",
//             isSuccess: true,
//           );
//         }
//       }
//
//
//       // ✅ Store company data (if using a singleton manager)
//       CompanyManager().setCompanyData(
//         name: companyData["name"] ?? '',
//         phone: companyData["phone"] ?? '',
//         companyId: companyData["companyId"] ?? '',
//         registrationId: companyData["registrationId"] ?? '',
//         otherPhone: companyData["otherPhone"] ?? '',
//         location: companyData["location"] ?? '',
//         email: companyData["email"] ?? '',
//         status: companyData["status"] ?? '',
//         senderId: companyData["senderId"] ?? '',
//         smsCount: companyData["smsCount"] ?? '',
//         subscriptionEndDate: companyData["subscriptionEndDate"] ?? '',
//       );
//
//       // ✅ Store user data
//       UserManager().setUserData(
//         gender: userData["gender"],
//         cID: userData["companyID"],
//         role: userData["role"],
//         userName: userData["firstName"],
//         userID: userData["StaffID"],
//       );
//
//       // ✅ Navigate to home screen
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const HomeScreen()),
//       );
//
//     } on TimeoutException catch (_) {
//       Provider.of<StoreViewModel>(context, listen: false).disableLoader();
//       showCustomSnackBar(context, "Login Failed: Request timed out!", isSuccess: false);
//     } catch (e, stackTrace) {
//       Provider.of<StoreViewModel>(context, listen: false).disableLoader();
//       debugPrint("❌ Error during sign-in: $e");
//       debugPrint(stackTrace.toString());
//       showCustomSnackBar(context, "Login Failed: An unexpected error occurred!", isSuccess: false);
//     }
//   }
//
//
// }

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piggy_bank/view_models/lock_pin_view_model.dart';
import 'package:provider/provider.dart';

import '../utils/company_Manager.dart';
import '../utils/nav.dart';
import '../utils/user_Manager.dart';
import '../utils/utils.dart';
import '../view_models/store_view_model.dart';
import '../views/home.dart';
import 'campany_DB.dart';

class UserAuth {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CampanyDBService instanceCM = CampanyDBService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> signInUser(BuildContext context, String email, String password) async {
    final storeVM = Provider.of<StoreViewModel>(context, listen: false);

    try {
      email = email.trim();
      password = password.trim();
      debugPrint("Signing in: $email / $password");

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? firebaseUser = userCredential.user;
      if (firebaseUser == null) {
        showCustomSnackBar(context, " Account not found, Please Sign Up.", isSuccess: false);
        return;
      }

      final userDoc = await firestore.collection('users').doc(firebaseUser.uid).get();
      if (!userDoc.exists) {
        showCustomSnackBar(context, "Login Failed: Invalid credentials!", isSuccess: false);
        return;
      }



      final userData = userDoc.data() as Map<String, dynamic>;
      debugPrint("✅ Login successful for ${userData['firstName']}");

      // ✅ Save user locally (UserManager)
      UserManager().setUserData(
        gender: userData["gender"],
        cID: userData["companyID"],
        role: userData["role"],
        userName: userData["firstName"],
        userID: userData["StaffID"],
      );

      // // ✅ Optionally fetch company data like before
      final companySnapshot = await firestore
          .collection('company')
          .where('companyId', isEqualTo: userData["companyID"])
          .limit(1)
          .get();
      //


      final companyData = companySnapshot.docs.first.data();
      if (companyData["status"]!="Approved") {
        storeVM.disableLoader();
        showCustomSnackBar(context, "Company Not Approved, Please Contact PiggyBank  Office!", isSuccess: false);
        return;
      }
      final now = DateTime.now();
      final subscriptionEndRaw = companyData["subscriptionEndDate"];
      DateTime? subscriptionEnd;

      if (subscriptionEndRaw != null && subscriptionEndRaw.toString().isNotEmpty) {
        try {
          subscriptionEnd = DateTime.tryParse(subscriptionEndRaw.toString());
        } catch (e) {
          storeVM.disableLoader();
          showCustomSnackBar(context, "Company Subscription Expired, Kindly Renew!", isSuccess: false);


        }
      }

      if (subscriptionEnd != null) {
        final daysLeft = subscriptionEnd.difference(now).inDays;

        if (daysLeft < 0) {
          storeVM.disableLoader();
          showCustomSnackBar(context, "Company Subscription Expired, Kindly Renew!", isSuccess: false);
          return;
        } else if (daysLeft <= 7) {
          storeVM.disableLoader();
          showCustomSnackBar(context, "Subscription expiring soon (${daysLeft.abs()} days left). Please renew.", isSuccess: false);
          return;
        }
      }
      CompanyManager().setCompanyData(
        name: companyData["name"]??'',
        phone: companyData["phone"]?? '',
        companyId: companyData["companyId"]?? '',
        registrationId: companyData["registrationId"]?? "",
        otherPhone: companyData["otherPhone"]??'',
        location: companyData["location"]?? "",
        email: companyData["email"]??"",
        status: companyData["status"]??"",
        senderId: companyData["senderId"]??"",
        smsCount: companyData["smsCount"]?? "",
        appLogo: companyData["appLogo"]?? "",
        subscriptionEndDate: companyData["subscriptionEndDate"]??"",

      );

      AppNavigator.toHome(context);

      // 🔹 Navigate to home


    } on TimeoutException {
      storeVM.disableLoader();
      showCustomSnackBar(context, "Login Failed: Request timed out!", isSuccess: false);
    } catch (e, stackTrace) {
      storeVM.disableLoader();
      debugPrint("❌ Error during sign-in: $e");
      debugPrint(stackTrace.toString());
      showCustomSnackBar(context, "Login Failed: Unexpected error occurred!", isSuccess: false);
    }
  }

  Future<void> userVerificationForPinReset(BuildContext context, String email, String password,String pin) async {
    final lockPinVM = Provider.of<LockPinViewModel>(context, listen: false);

    try {
      email = email.trim();
      password = password.trim();

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? firebaseUser = userCredential.user;
      if (firebaseUser == null) {
        showCustomSnackBar(context, " Account not found, Please Sign Up.", isSuccess: false);
        return;
      }

      final userDoc = await firestore.collection('users').doc(firebaseUser.uid).get();
      if (!userDoc.exists) {
        showCustomSnackBar(context, "Login Failed: Invalid credentials!", isSuccess: false);
        return;
      }
      lockPinVM.saveLockPin(pin);
      AppNavigator.toLock(context);
      showCustomSnackBar(context, "User Verification Successfully!, Now Set New Pin", isSuccess: true);
      // 🔹 Navigate to home


    } on TimeoutException {

      showCustomSnackBar(context, "Login Failed: Request timed out!", isSuccess: false);
    } catch (e, stackTrace) {
      AppNavigator.toLock(context);
      debugPrint("❌ Error during sign-in: $e");
      debugPrint(stackTrace.toString());
      showCustomSnackBar(context, "Login Failed: Unexpected error occurred!", isSuccess: false);
    }
  }


  Future<void> resetPassword(BuildContext context, String email) async {

    try {
      await _auth.sendPasswordResetEmail(email: email);
      AppNavigator.toHome(context);

      showCustomSnackBar(context, " Password reset email sent to $email", isSuccess: true);

    } on FirebaseAuthException catch (e) {
      String message = "";
      if (e.code == 'user-not-found') {
        message = "❌ No user found for that email.";
      } else if (e.code == 'invalid-email') {

        message = "❌ Invalid email format.";
      } else {
        message = "⚠️ Error: ${e.message}";
      }
      showCustomSnackBar(context, message, isSuccess: false);
      //await _handleError(context, storeViewModel,message);

    }
  }
}
