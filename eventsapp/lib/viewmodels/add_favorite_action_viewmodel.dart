// lib/viewmodels/add_favorite_action_viewmodel.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/providers/add_favorite_action_provider.dart';
import '../data/repositories/favorite_repository.dart';

class FavoriteActionViewModel extends AsyncNotifier<void> {
  late final FavoriteRepository _repository;

  @override
  Future<void> build() async {
    _repository = ref.read(favoriteRepositoryProvider);
  }

  Future<void> addToFavorites(String userId, int eventId) async {
    state = const AsyncLoading();
    try {
      // Llamada al repositorio para agregar el evento a los favoritos
      await _repository.addEventToFavorites(userId, eventId);
      
      // Si todo va bien, cambiamos el estado a AsyncData sin devolver datos
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final favoriteActionViewModelProvider =
    AsyncNotifierProvider<FavoriteActionViewModel, void>(
        () => FavoriteActionViewModel());
