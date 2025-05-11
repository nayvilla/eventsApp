enum Environment { local, production }

class ApiConfig {
  static const Environment env = Environment.production; // Cambia a `local` para probar localmente

  static String get baseUrl {
    switch (env) {
      case Environment.local:
        return 'http://localhost:3000';
      case Environment.production:
        return 'https://ivory-cyclic-colby.glitch.me';
    }
  }
}

class ApiConstants {
  static String get login => '${ApiConfig.baseUrl}/api/users/login';
  static String get register => '${ApiConfig.baseUrl}/api/users/register';
  static String get events => '${ApiConfig.baseUrl}/api/events';
  static String eventById(String id) => '${ApiConfig.baseUrl}/api/events/$id';
  static String get eventsByCategory => '${ApiConfig.baseUrl}/api/events?category=';
  static String userFavorites(String userId) => '${ApiConfig.baseUrl}/api/users/$userId/favorites';
}
