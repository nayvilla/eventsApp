import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/providers/theme_provider.dart';
import 'routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    // Establece el tema VIU por defecto al iniciar
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(themeProvider.notifier).setTheme(AppThemeMode.viu);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Events App',
      theme: theme,
      initialRoute: AppRoutes.login, // Redirige a la pantalla de inicio de sesión
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
