import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../core/providers/auth_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// ViewModel para manejar el estado del login.
/// Expone un método `login` y mantiene el estado del usuario autenticado.
class AuthViewModel extends AsyncNotifier<UserModel?> {
  @override
  FutureOr<UserModel?> build() {
    // Inicialmente no hay usuario logueado
    return null;
  }

  /// Intenta iniciar sesión con el repositorio.
  /// Si tiene éxito, guarda el usuario y actualiza el estado.
  Future<void> login(String email, String password) async {
    state = const AsyncLoading();
    final repo = ref.read(authRepositoryProvider);

    try {
      final user = await repo.login(email, password);
      state = AsyncData(user);
    } catch (e) {
      state = AsyncError(e.toString(), StackTrace.current);
    }
  }

  /// Limpia el estado (útil para cerrar sesión)
  void logout() {
    state = const AsyncData(null);
  }

  /// Registra un nuevo usuario
  Future<void> register(String nombre, String email, String password) async {
    state = const AsyncLoading();
    final repo = ref.read(authRepositoryProvider);

    try {
      final user = await repo.register(nombre, email, password);
      state = AsyncData(user);
    } catch (e) {
      state = AsyncError(e.toString(), StackTrace.current);
    }
  }

}

/// Provider global que puedes usar desde la UI
final authViewModelProvider =
    AsyncNotifierProvider<AuthViewModel, UserModel?>(() => AuthViewModel());
