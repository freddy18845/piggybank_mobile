// ignore: file_names

import '../models/customerData.dart';


class CustomerManager {

  static final CustomerManager _instance = CustomerManager._internal();

  factory CustomerManager() => _instance;

  CustomerManager._internal();
  CustomerData customerData =
  CustomerData();

  void setCustomerData({ required CustomerData data}) {
    customerData = data;
  }



  CustomerData getUserData() {
    return customerData;
  }
  clear(){
    customerData = CustomerData();
  }

}