// lib/views/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../routes/app_routes.dart';
import '../viewmodels/auth_viewmodel.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final user = ref.watch(authViewModelProvider).value;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cuenta'),
        backgroundColor: theme.primaryColor,
        foregroundColor: theme.appBarTheme.foregroundColor,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3, // estamos en la segunda pantalla
        selectedItemColor: theme.primaryColor,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, AppRoutes.home);
              break;
            case 1:
              Navigator.pushNamed(context, AppRoutes.calendar);
              break;
            case 2:
              Navigator.pushNamed(context, AppRoutes.favorite);
              break;
            case 3:
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Calendario'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favoritos'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: theme.primaryColor,
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('lib/assets/avatar.png'), // imagen por defecto
                ),
                const SizedBox(height: 12),
                Text(user?.nombre ?? 'Nombre usuario',
                    style: theme.textTheme.titleLarge?.copyWith(color: Colors.white)),
                Text(user?.email ?? 'email@dominio.com',
                    style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white70)),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      Text("Completa tu perfil", style: theme.textTheme.bodySmall?.copyWith(color: Colors.white)),
                      const SizedBox(height: 6),
                      LinearProgressIndicator(
                        value: 0.6,
                        backgroundColor: Colors.white24,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 4),
                      Text("60/100", style: theme.textTheme.bodySmall?.copyWith(color: Colors.white70)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _profileOption(context, icon: Icons.edit, text: "Editar Perfil", onTap: () {}),
                _profileOption(context, icon: Icons.lock, text: "Cambiar Contraseña", onTap: () {}),
                _profileOption(context, icon: Icons.description, text: "Términos y Condiciones", onTap: () {}),
                _profileOption(context, icon: Icons.privacy_tip, text: "Política de Privacidad", onTap: () {}),
                _profileOption(context, icon: Icons.logout, text: "Cerrar Sesión", onTap: () {
                  Navigator.pushNamed(context, AppRoutes.login);
                }, isLogout: true),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _profileOption(BuildContext context,
      {required IconData icon, required String text, required VoidCallback onTap, bool isLogout = false}) {
    final theme = Theme.of(context);
    return Card(
      color: theme.cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Icon(icon, color: isLogout ? Colors.red : theme.primaryColor),
        title: Text(text, style: theme.textTheme.bodyMedium),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
