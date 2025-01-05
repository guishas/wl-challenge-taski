import 'package:flutter/material.dart';
import 'package:wl_challenge_taski/ui/home/home_page.dart';

class AppRoutes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(
          settings: const RouteSettings(name: '/home'),
          builder: (context) => const HomePage(),
        );
      default:
        return MaterialPageRoute(
          settings: const RouteSettings(name: '/home'),
          builder: (context) => const HomePage(),
        );
    }
  }
}
