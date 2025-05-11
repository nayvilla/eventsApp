import 'package:flutter/material.dart';

// Importacion de vistas
import '../views/auth/login_screen.dart';
import '../views/auth/register_screen.dart';
import '../views/home_screen.dart';
import '../views/calendar_screen.dart';
import '../views/event_detail_screen.dart';
import '../views/map_screen.dart';
import '../views/profile_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String calendar = '/calendar';
  static const String eventDetail = '/event-detail';
  static const String map = '/map';
  static const String profile = '/profile';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case calendar:
        return MaterialPageRoute(builder: (_) => const CalendarScreen());
      case eventDetail:
      final eventId = settings.arguments as int;
        return MaterialPageRoute(builder: (_) => EventDetailScreen(eventId: eventId));
      case map:
        return MaterialPageRoute(builder: (_) => const MapScreen());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('404 - Página no encontrada')),
          ),
        );
    }
  }
}
