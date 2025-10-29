// lib/managers/company_manager.dart
import 'package:shared_preferences/shared_preferences.dart';

import '../models/companyData.dart';


class CompanyManager {
  static final CompanyManager _instance = CompanyManager._internal();

  factory CompanyManager() => _instance;

  CompanyManager._internal();

  CompanyData companyData = CompanyData(
      name: '',
      phone: '',
      companyId: '',
      registrationId: '',
      otherPhone: '',
      location: '',
      email: '',
      status: '',
      senderId: '',
      smsCount: '',
      appLogo: '',
      subscriptionEndDate: ''
  );

  void setCompanyData({
    required String name,
    required String phone,
    required String companyId,
    required String registrationId,
    required String otherPhone,
    required String location,
    required String email,
    required String status,
    required String senderId,
    required String smsCount,
    required String appLogo,
    required String subscriptionEndDate,
  }) {
    companyData = CompanyData(
        name: name,
        phone: phone,
        companyId: companyId,
        registrationId: registrationId,
        otherPhone: otherPhone,
        location: location,
        email: email,
        status: status,
        senderId: senderId,
        smsCount: smsCount,
        appLogo:appLogo,
        subscriptionEndDate: subscriptionEndDate
    );
  }

  CompanyData getCompanyData() {
    return companyData;
  }

  // Save to SharedPreferences
  Future<void> saveCompanyDetails() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('companyId', companyData.companyId!);
    await prefs.setString('companyName', companyData.name!);
    await prefs.setString('companyPhone', companyData.phone!);
    await prefs.setString('registrationId', companyData.registrationId!);
    await prefs.setString('otherPhone', companyData.otherPhone!);
    await prefs.setString('location', companyData.location!);
    await prefs.setString('email', companyData.email!);
    await prefs.setString('status', companyData.status!);
    await prefs.setString('senderId', companyData.senderId!);
    await prefs.setString('smsCount', companyData.smsCount!);
    await prefs.setString('appLogo', companyData.appLogo!);
    await prefs.setString('subscriptionEndDate', companyData.subscriptionEndDate!);
  }

  // Load from SharedPreferences
  Future<void> loadCompanyDetails() async {
    final prefs = await SharedPreferences.getInstance();
    companyData = CompanyData(
      companyId: prefs.getString('companyId') ?? '',
      name: prefs.getString('companyName') ?? '',
      phone: prefs.getString('companyPhone') ?? '',
      registrationId: prefs.getString('registrationId') ?? '',
      otherPhone: prefs.getString('otherPhone') ?? '',
      location: prefs.getString('location') ?? '',
      email: prefs.getString('email') ?? '',
      status: prefs.getString('status') ?? '',
      senderId: prefs.getString('senderId') ?? '',
      smsCount: prefs.getString('smsCount') ?? '',
      appLogo: prefs.getString('appLogo') ?? '',
      subscriptionEndDate: prefs.getString('subscriptionEndDate') ?? '',
    );
  }

  // Clear saved company details
  Future<void> clearCompanyDetails() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('companyId');
    await prefs.remove('companyName');
    await prefs.remove('companyPhone');
    await prefs.remove('registrationId');
    await prefs.remove('otherPhone');
    await prefs.remove('location');
    await prefs.remove('email');
    await prefs.remove('status');
    await prefs.remove('senderId');
    await prefs.remove('smsCount');
    await prefs.remove('appLogo');
    await prefs.remove('subscriptionEndDate');
    companyData = CompanyData(
        name: '',
        phone: '',
        companyId: '',
        registrationId: '',
        otherPhone: '',
        location: '',
        email: '',
        status: '',
        senderId: '',
        smsCount: '',
        appLogo: '',
        subscriptionEndDate: ''
    );
  }
}
