import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:piggy_bank/constant.dart';
import 'package:piggy_bank/utils/nav.dart';
import 'package:piggy_bank/utils/route_memory.dart';
import 'package:piggy_bank/utils/utils.dart';
import 'package:piggy_bank/view_models/customers_view_model.dart';
import 'package:piggy_bank/view_models/deposit_view_model.dart';
import 'package:piggy_bank/view_models/lock_pin_view_model.dart';
import 'package:piggy_bank/view_models/store_view_model.dart';
import 'package:piggy_bank/view_models/transaction_view_model.dart';
import 'package:piggy_bank/views/add_customer_screen.dart';
import 'package:piggy_bank/views/balance_and_statement_screen.dart';
import 'package:piggy_bank/views/customers_list_screen.dart';
import 'package:piggy_bank/views/deposit_screen.dart';
import 'package:piggy_bank/views/home.dart';
import 'package:piggy_bank/views/lock_screen.dart';
import 'package:piggy_bank/views/login_screen.dart';
import 'package:piggy_bank/views/settings.dart';
import 'package:piggy_bank/views/splash_screen.dart';
import 'package:piggy_bank/views/transaction_history.dart';
import 'package:piggy_bank/views/withdrawal_screen.dart';
import 'package:provider/provider.dart';

/// ✅ Global navigator key for safe navigation
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  Timer? _idleTimer;

  /// ⏱️ Idle timeout duration
  final Duration idleTimeout = const Duration(minutes: 20);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _resetIdleTimer();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _idleTimer?.cancel();
    super.dispose();
  }

  /// 🔁 Reset timer whenever user interacts
  void _resetIdleTimer() {
    _idleTimer?.cancel();
    _idleTimer = Timer(idleTimeout, _onUserIdle);
  }

  void _onUserIdle() {
    debugPrint("⚠️ App has been idle for ${idleTimeout.inSeconds} seconds");

    final currentRoute = AppNavigator.getCurrentRouteName();
    debugPrint("🧭 Current route on idle: $currentRoute");

    if (currentRoute != '/login' && currentRoute != '/lock' && currentRoute!= null) {
      // 💾 Save the current route before locking
      RouteMemory.save(currentRoute);
      AppNavigator.toLock(navigatorKey.currentContext);
    } else {
      debugPrint("🔒 Idle detected but already on $currentRoute — no navigation triggered.");
    }
  }




  /// 🔄 Handle app lifecycle
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _resetIdleTimer();
    } else if (state == AppLifecycleState.paused) {
      _idleTimer?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      // Detect user tap or scroll
      onPointerDown: (_) => _resetIdleTimer(),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => DepositViewModel()),
          ChangeNotifierProvider(create: (_) => TransactionViewModel()),
          ChangeNotifierProvider(create: (_) => StoreViewModel()),
          ChangeNotifierProvider(create: (_) => CustomersViewModel()),
          ChangeNotifierProvider(create: (_) => LockPinViewModel()),
        ],
        child: MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          title: APP_NAME,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor:SECONDARY_COLOR),
            useMaterial3: true,
          ),

          /// 🗺️ Define routes
          initialRoute: '/splash',
          routes: {
            '/splash': (_) => const SplashScreen(),
            '/login': (_) => const LoginScreen(),
            '/lock': (_) => const LockScreen(),
            '/home': (_) => const HomeScreen(),
            '/deposit': (_) => const DepositAndLoansScreen(),
            '/withdrawal': (_) => const WithdrawalScreen(),
            '/addCustomer': (_) => const AddCustomersScreen(),
            '/history': (_) => const TransactionHistoryScreen(),
            '/statement': (_) => const BalanceAndStatementsScreen(),
            '/customerList': (_) => const CustomerListScreen(),
            '/settings': (_) => const SettingsScreen(),


          },
        ),
      ),
    );
  }
}