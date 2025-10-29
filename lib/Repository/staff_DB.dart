// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import '../constant.dart';
// import '../utils/utils.dart';
//
//
//  class StaffDBService  {
//   // Reference to the Firestore instance
//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//
//   // Add a new user document to the 'users' collection
//    createUser(BuildContext context, Map <String, dynamic> body) async {
//     try {
//
//       await firestore.collection('users').add(body);
//       Navigator.pop(context);
//       showCustomSnackBar(context, "User Added Successfully!", isSuccess: true);
//
//
//     } catch (e) {
//       Navigator.pop(context);
//       showCustomSnackBar(context, "User  Data Addition   Failed!", isSuccess: false);
//
//     }
//     }
//
//
//
//
//   // Add a get all Company user document to the 'users' collection
//   getUsers(String companyID,String staffID) async {
//     try {
//       // Query the 'users' collection where 'companyId' matches 'PGYB0001'
//       QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//           .collection('users')
//           .where('companyID', isEqualTo: companyID)
//           .get();
//
//       // Clear the list to avoid duplicate entries
//       userStorage.clear();
//
//       // Add each document's data to UserStorage
//       for (var doc in querySnapshot.docs) {
//         String documentId = doc.id;
//         Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;
//         if (userData != null) {
//           // Add the document ID to the user data map
//           userData['documentId'] = documentId;
//           // Add the user data to the list
//           userStorage[documentId] = userData;
//         }else {
//           debugPrint('Null data found in document: $documentId');
//         }
//
//             }
//     } catch (e) {
//       print('Error getting users: $e');
//     }
//   }
//
//
//
//
//
//   // Update a particular  User from 'users' collection
//  updateUser(BuildContext context,String documentId, Map<String, dynamic> updatedData) async {
//     try {
//       // Reference the document using its ID and update it with new data
//       await FirebaseFirestore.instance.collection('users').doc(documentId).update(updatedData);
//       Navigator.pop(context);
//       showCustomSnackBar(context, "User Data Updated  Successfully!", isSuccess: true);
//
//     } catch (e) {
//       Navigator.pop(context);
//       showCustomSnackBar(context, "User  Update  Failed!", isSuccess: false);
//       print('Error updating user: $e');
//     }
//   }
//
//   // Delete a particular  User from 'users' collection
//   deleteUser(context, String documentId,) async {
//     try {
//       // Reference the document using its ID and update it with new data
//       await FirebaseFirestore.instance.collection('users').doc(documentId).delete();
//       showCustomSnackBar(context, "User Deleted Successfully!", isSuccess: true);
//       //getUsers();
//     } catch (e) {
//
//       showCustomSnackBar(context, "User  Delete  Failed!", isSuccess: false);
//      // getUsers();
//     }
//   }
//  }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../constant.dart';
import '../utils/utils.dart';

class StaffDBService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // 🔹 CREATE USER (with your own custom ID)
  Future<void> createUser(BuildContext context, Map<String, dynamic> body) async {
    try {
      // Ensure the body contains a unique userID (you can generate this before calling)
      final String userID = body["userID"];

      await firestore.collection('users').doc(userID).set(body);

      Navigator.pop(context);
      showCustomSnackBar(context, "User Added Successfully!", isSuccess: true);
    } catch (e) {
      Navigator.pop(context);
      showCustomSnackBar(context, "User Data Addition Failed!", isSuccess: false);
      debugPrint('Error adding user: $e');
    }
  }

  // 🔹 GET USERS (filtered by companyID)
  Future<void> getUsers(String companyID, String staffID) async {
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('users')
          .where('companyID', isEqualTo: companyID)
          .get();

      // Clear the list to avoid duplicates
      userStorage.clear();

      for (var doc in querySnapshot.docs) {
        final Map<String, dynamic>? userData =
        doc.data() as Map<String, dynamic>?;
        if (userData != null) {
          userData['documentId'] = doc.id;
          userStorage[doc.id] = userData;
        } else {
          debugPrint('Null data found in document: ${doc.id}');
        }
      }
    } catch (e) {
      debugPrint('Error getting users: $e');
    }
  }

  // 🔹 UPDATE USER (by document/userID)
  Future<void> updateUser(
      BuildContext context, String documentId, Map<String, dynamic> updatedData) async {
    try {
      await firestore.collection('users').doc(documentId).update(updatedData);
      Navigator.pop(context);
      showCustomSnackBar(context, "User Data Updated Successfully!", isSuccess: true);
    } catch (e) {
      Navigator.pop(context);
      showCustomSnackBar(context, "User Update Failed!", isSuccess: false);
      debugPrint('Error updating user: $e');
    }
  }

  // 🔹 DELETE USER
  Future<void> deleteUser(BuildContext context, String documentId) async {
    try {
      await firestore.collection('users').doc(documentId).delete();
      showCustomSnackBar(context, "User Deleted Successfully!", isSuccess: true);
    } catch (e) {
      showCustomSnackBar(context, "User Delete Failed!", isSuccess: false);
      debugPrint('Error deleting user: $e');
    }
  }
}
