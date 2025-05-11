// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../routes/app_routes.dart';
import '../../viewmodels/auth_viewmodel.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/social_icon_button.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }
  // Método para cargar las credenciales guardadas
  Future<void> _loadSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('email');
    final savedPassword = prefs.getString('password');

    if (savedEmail != null) {
      _emailController.text = savedEmail;
      setState(() => _savePassword = true);
    }

    if (savedPassword != null) {
      _passwordController.text = savedPassword;
      setState(() => _savePassword = true);
    }
  }

  bool _obscurePassword = true;
  bool _savePassword = true; // Controlador para el checkbox

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authState = ref.watch(authViewModelProvider);
    final authNotifier = ref.read(authViewModelProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Imagen superior
            Container(
              height: 400,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/assets/login_background.jpg'),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),

            // Contenedor principal con borde redondeado encima
            Transform.translate(
              offset: const Offset(0, 300),
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Center(
                        child: Text("Inicio de Sesión", style: theme.textTheme.titleLarge),
                      ),
                      const SizedBox(height: 32),

                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Correo Electrónico',
                          filled: true,
                          fillColor: theme.cardColor,
                          border: OutlineInputBorder(borderSide: BorderSide.none),
                          labelStyle: theme.textTheme.bodyMedium,
                        ),
                      ),
                      const SizedBox(height: 16),

                      TextField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
                          filled: true,
                          fillColor: theme.cardColor,
                          border: OutlineInputBorder(borderSide: BorderSide.none),
                          labelStyle: theme.textTheme.bodyMedium,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword ? Icons.visibility_off : Icons.visibility,
                              color: theme.iconTheme.color,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: _savePassword,
                            onChanged: (bool? newValue) {
                              setState(() {
                                _savePassword = newValue ?? false; // Actualiza el estado del checkbox
                              });
                            },
                          ),
                          const Text("¿Quieres guardar tu contraseña?"),
                        ],
                      ),

                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            final email = _emailController.text.trim();
                            final password = _passwordController.text.trim();

                            if (email.isEmpty || password.isEmpty) {
                              showCustomSnackBar(context, 'Por favor, completa todos los campos', false);
                              return;
                            }

                            await authNotifier.login(email, password);

                            final result = ref.read(authViewModelProvider);

                            if (result.hasError) {
                              showCustomSnackBar(context, result.error.toString(), false);
                            } else if (result.hasValue && result.value != null) {
                              // Verificar si el checkbox está marcado
                              if (_savePassword) {
                                // Guardar las credenciales si el checkbox está marcado
                                final prefs = await SharedPreferences.getInstance();
                                await prefs.setString('email', email);
                                await prefs.setString('password', password);  // O lo que necesites guardar
                              }
                              Navigator.pushReplacementNamed(context, AppRoutes.home);
                              showCustomSnackBar(context, 'Inicio de sesión exitoso', true);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: theme.primaryColor,
                            foregroundColor: theme.elevatedButtonTheme.style?.foregroundColor?.resolve({}),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text("Iniciar Sesión", style: theme.textTheme.titleMedium),
                        ),
                      ),

                      const SizedBox(height: 24),
                      Center(
                        child: Text("Iniciar sesión con", style: theme.textTheme.bodyMedium),
                      ),
                      const SizedBox(height: 16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SocialLoginIcon(icon: Icons.facebook),
                          SocialLoginIcon(icon: Icons.g_mobiledata_sharp),
                          SocialLoginIcon(icon: Icons.close_rounded),
                          SocialLoginIcon(icon: Icons.apple),
                        ],
                      ),

                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("¿Aún no tienes una cuenta? ", style: theme.textTheme.bodyMedium),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(context, AppRoutes.register);
                            },
                            child: Text(
                              "Resgistrate aquí",
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (authState.isLoading)
              Positioned.fill(
                child: ColoredBox(
                  color: theme.cardColor.withValues(alpha: 0.5),
                  child: Center(child: LoginLoading()),
                ),
              ),
          ],
        ),
      ),
    );
  }
}




