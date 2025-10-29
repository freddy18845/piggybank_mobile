import 'package:flutter/foundation.dart';

/// 🧠 Stores the last active route before the app locks.
class RouteMemory {
  static String? _lastRoute;

  static String? get lastRoute => _lastRoute;

  /// Save the last visited route (before lock)
  static void save(String? routeName) {
    if (routeName == null) return;
    if (routeName == '/login' || routeName == '/lock') return; // skip login/lock
    _lastRoute = routeName;
    debugPrint("💾 Saved last route: $_lastRoute");
  }

  /// Clear the stored route (after restore)
  static void clear() {
    debugPrint("🧹 Cleared saved route");
    _lastRoute = null;
  }
}
