// lib/viewmodels/favorite_viewmodel.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/event_model.dart';
import '../core/providers/event_provider.dart';
import 'auth_viewmodel.dart';

class FavoriteViewModel extends AsyncNotifier<List<EventModel>> {
  @override
  Future<List<EventModel>> build() async {
    final authState = ref.watch(authViewModelProvider);
    final repo = ref.read(eventRepositoryProvider);

    final userId = authState.value?.id.toString();
    if (userId == null) {
      return [];
    }

    try {
      return await repo.getUserFavorites(userId);
    } catch (e) {
      throw Exception("Error al cargar favoritos: $e");
    }
  }
  /// Recargar favoritos del usuario
  Future<void> reloadUserFavorities(String userId) async {
    // Cambiar el estado a "cargando" mientras obtenemos los datos
    state = const AsyncLoading();

    // Obtener el repositorio para hacer la consulta al API
    final repo = ref.read(eventRepositoryProvider);

    try {
      // Obtener los favoritos desde el API
      final userFavorites = await repo.getUserFavorites(userId);
      // Actualizar el estado con los datos obtenidos
      state = AsyncData(userFavorites);
    } catch (e) {
      // Si hay error, actualizar el estado con el error
      state = AsyncError(e.toString(), StackTrace.current);
    }
  }
}

final favoriteViewModelProvider =
    AsyncNotifierProvider<FavoriteViewModel, List<EventModel>>(
        () => FavoriteViewModel());
