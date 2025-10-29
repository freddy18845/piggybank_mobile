
import 'package:flutter/cupertino.dart';
import 'package:piggy_bank/utils/route_memory.dart';

import '../main.dart';

class AppNavigator {
  /// 🧭 Navigate to   splash Screen safely
  static void toSplash(BuildContext? context) {
    final nav = navigatorKey.currentState;
    if (nav == null) {
      debugPrint("❌ Navigator not ready!");
      return;
    }

    // ✅ Get current route from navigator's overlay context
    final currentRoute = nav.overlay?.context != null
        ? ModalRoute.of(nav.overlay!.context)?.settings.name
        : null;

    if (currentRoute == '/splash') {
      debugPrint("⏸️ Already on LoginScreen.");
      return;
    }

    debugPrint("🧭 Navigating to Login from: $currentRoute");
    nav.pushNamedAndRemoveUntil('/splash', (route) => false);
  }

  /// 🧭 Navigate to Login Screen safely
  static void toLogin(BuildContext? context) {
    final nav = navigatorKey.currentState;
    if (nav == null) {
      debugPrint("❌ Navigator not ready!");
      return;
    }

    // ✅ Get current route from navigator's overlay context
    final currentRoute = nav.overlay?.context != null
        ? ModalRoute.of(nav.overlay!.context)?.settings.name
        : null;

    if (currentRoute == '/login') {
      debugPrint("⏸️ Already on LoginScreen.");
      return;
    }

    debugPrint("🧭 Navigating to Login from: $currentRoute");
    nav.pushNamedAndRemoveUntil('/login', (route) => false);
  }

  /// 🔒 Navigate to Lock Screen safely
  static String? getCurrentRouteName() {
    final nav = navigatorKey.currentState;
    if (nav == null) return null;

    Route? currentRoute;
    nav.popUntil((route) {
      currentRoute = route;
      return true;
    });

    return currentRoute?.settings.name;
  }

  static void toLock(BuildContext? context) {
    final nav = navigatorKey.currentState;
    if (nav == null) return;

    final currentRoute = getCurrentRouteName();
    debugPrint("🔍 Current top route: $currentRoute");

    if (currentRoute == '/lock' || currentRoute == '/login') {
      debugPrint("⏸️ Idle navigation skipped on $currentRoute.");
      return;
    }

    debugPrint("🔒 Navigating to Lock from: $currentRoute");
    nav.pushNamed('/lock');
  }


  /// 🏠 Navigate to Home Screen safely
  static void toHome(BuildContext? context) {
    final nav = navigatorKey.currentState;
    if (nav == null) {
      debugPrint("❌ Navigator not ready!");
      return;
    }

    // ✅ Get current route from navigator's overlay context
    final currentRoute = nav.overlay?.context != null
        ? ModalRoute.of(nav.overlay!.context)?.settings.name
        : null;

    if (currentRoute == '/home') {
      debugPrint("⏸️ Already on HomeScreen.");
      return;
    }

    debugPrint("🏠 Navigating to Home from: $currentRoute");
    nav.pushNamedAndRemoveUntil('/home', (route) => false);
  }
  /// 🏠 Navigate to Home Screen safely
  static void toDeposit(BuildContext? context) {
    final nav = navigatorKey.currentState;
    if (nav == null) {
      debugPrint("❌ Navigator not ready!");
      return;
    }

    // ✅ Get current route from navigator's overlay context
    final currentRoute = nav.overlay?.context != null
        ? ModalRoute.of(nav.overlay!.context)?.settings.name
        : null;

    if (currentRoute == '/deposit') {
      debugPrint("⏸️ Already on DepositScreen.");
      return;
    }

    debugPrint("🏠 Navigating to Deposit from: $currentRoute");
    nav.pushNamedAndRemoveUntil('/deposit', (route) => false);
  }
  /// 🏠 Navigate to Home Screen safely
  static void toWithdrawal(BuildContext? context) {
    final nav = navigatorKey.currentState;
    if (nav == null) {
      debugPrint("❌ Navigator not ready!");
      return;
    }

    // ✅ Get current route from navigator's overlay context
    final currentRoute = nav.overlay?.context != null
        ? ModalRoute.of(nav.overlay!.context)?.settings.name
        : null;

    if (currentRoute == '/withdrawal') {
      debugPrint("⏸️ Already on WithdrawalScreen.");
      return;
    }

    debugPrint("🏠 Navigating to Withdrawal from: $currentRoute");
    nav.pushNamedAndRemoveUntil('/withdrawal', (route) => false);
  }
  /// 🏠 Navigate to Home Screen safely
  static void toAddCustomer(BuildContext? context) {
    final nav = navigatorKey.currentState;
    if (nav == null) {
      debugPrint("❌ Navigator not ready!");
      return;
    }

    // ✅ Get current route from navigator's overlay context
    final currentRoute = nav.overlay?.context != null
        ? ModalRoute.of(nav.overlay!.context)?.settings.name
        : null;

    if (currentRoute == '/addCustomer') {
      debugPrint("⏸️ Already on AddCustomerScreen.");
      return;
    }

    debugPrint("🏠 Navigating to AddCustomer from: $currentRoute");
    nav.pushNamedAndRemoveUntil('/addCustomer', (route) => false);
  }
  /// 🏠 Navigate to Home Screen safely
  static void toHistory(BuildContext? context, bool? isTodayTransaction) {
    final nav = navigatorKey.currentState;
    if (nav == null) {
      debugPrint("❌ Navigator not ready!");
      return;
    }

    // ✅ Get current route from navigator's overlay context
    final currentRoute = nav.overlay?.context != null
        ? ModalRoute.of(nav.overlay!.context)?.settings.name
        : null;

    if (currentRoute == '/history') {
      debugPrint("⏸️ Already on HistoryScreen.");
      return;
    }

    debugPrint("🏠 Navigating to history from: $currentRoute");

    // Use the isTodayTransaction parameter if needed, e.g.:
    nav.pushNamedAndRemoveUntil(
      '/history',
          (route) => false,
      arguments: {'isTodayTransaction': isTodayTransaction},
    );
  }
  static void toStatement(BuildContext? context) {
    final nav = navigatorKey.currentState;
    if (nav == null) {
      debugPrint("❌ Navigator not ready!");
      return;
    }

    // ✅ Get current route from navigator's overlay context
    final currentRoute = nav.overlay?.context != null
        ? ModalRoute.of(nav.overlay!.context)?.settings.name
        : null;

    if (currentRoute == '/statement') {
      debugPrint("⏸️ Already on Statement Screen.");
      return;
    }

    debugPrint("🏠 Navigating to statement from: $currentRoute");
    nav.pushNamedAndRemoveUntil('/statement', (route) => false);
  }

  static void toCustomerList(BuildContext? context) {
    final nav = navigatorKey.currentState;
    if (nav == null) {
      debugPrint("❌ Navigator not ready!");
      return;
    }

    // ✅ Get current route from navigator's overlay context
    final currentRoute = nav.overlay?.context != null
        ? ModalRoute.of(nav.overlay!.context)?.settings.name
        : null;

    if (currentRoute == '/customerList') {
      debugPrint("⏸️ Already on CustomerList Screen.");
      return;
    }

    debugPrint("🏠 Navigating to CustomerList from: $currentRoute");
    nav.pushNamedAndRemoveUntil('/customerList', (route) => false);
  }
  static void toSettingsScreen(BuildContext? context) {
    final nav = navigatorKey.currentState;
    if (nav == null) {
      debugPrint("❌ Navigator not ready!");
      return;
    }

    // ✅ Get current route from navigator's overlay context
    final currentRoute = nav.overlay?.context != null
        ? ModalRoute.of(nav.overlay!.context)?.settings.name
        : null;

    if (currentRoute == '/settings') {
      debugPrint("⏸️ Already on settings Screen.");
      return;
    }

    debugPrint("🏠 Navigating to settings from: $currentRoute");
    nav.pushNamedAndRemoveUntil('/settings', (route) => false);
  }
}




