
import 'package:flutter/material.dart';
import 'package:piggy_bank/constant.dart';

import '../Repository/customer_DB.dart';
import '../models/customerData.dart';
import '../utils/user_Manager.dart';
import '../utils/utils.dart';

class CustomersViewModel extends ChangeNotifier {
  CustomerData customerData = CustomerData();
  final CustomerDBServices instance = CustomerDBServices();


  void setCustomerData( context ,Map<String, dynamic> data) {
    // Ensure required fields are filled, excluding 'Middle Name'
    final UserInfo = UserManager().getUserData();
    if (data["firstName"] == null || data["firstName"] == "") {
      showCustomSnackBar(context, "First name is required.", isSuccess: false);
      return; // Stop execution if required fields are missing
    }
    if (data["lastName"] == null || data["lastName"] == "") {
      showCustomSnackBar(context, "Last name is required.", isSuccess: false);
      return; // Stop execution if required fields are missing
    }

    if (data["contact"] == null || data["contact"] == "") {
      showCustomSnackBar(context, "Contact is required.", isSuccess: false);
      return; // Stop execution if required fields are missing
    }
    if (data["nextOfKinContact"] == null || data["nextOfKinContact"] == "" ) {
      showCustomSnackBar(context, "Valid email is required.", isSuccess: false);
      return; // Stop execution if email is invalid
    }

    if (data["dob"] == null || data["dob"] == "" ) {
      showCustomSnackBar(context, " date is required.", isSuccess: false);
      return; // Stop execution if email is invalid
    }
    if (data["relation"] == null || data["relation"] == "" ) {
      showCustomSnackBar(context, " date is required.", isSuccess: false);
      return; // Stop execution if email is invalid
    }


    customerData
      ..firstName = data["firstName"]
      ..lastName = data["lastName"]
      ..middleName = data["middleName"]
      ..staffId = UserInfo.staffId
      ..companyID = UserInfo.companyId
      ..nextOfKinOccupation = data["nextOfKinOccupation"]
      ..contact = data["contact"] // Ensure contact is an int
      ..email = data["email"]
      ..dob = data["dob"]
      ..relation = data["relation"]
      ..nextOfKinContact = data["nextOfKinContact"]
      ..location = data["location"]
      ..nextOfKinName = data["nextOfKinName"]
      ..gpsAddress = data["gpsAddress"]
      ..occupation = data["occupation"]
      ..idCardType = data["idCardType"]
      ..customerId = "${customersStorage.length + 1}"
      ..status = UserInfo.role =="Administrator"?'Approved':"Pending"
      ..idNumber = data["idNumber"];

  }

  getCustomer(context ) async {
    final UserInfo = UserManager().getUserData();
    instance.getCustomers(UserInfo.companyId,);
    notifyListeners();
  }

  Future<void> createCustomer(BuildContext context, Map<String, dynamic> data) async {

    setCustomerData(context, data);
    try {

      await instance.createCustomer(context, customerData.toJson());
    } catch (e) {
      showCustomSnackBar(context, "Failed to create customer.", isSuccess: false);

    }
    notifyListeners();
  }



}
