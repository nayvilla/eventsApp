// lib/data/repositories/favorite_repository.dart
import '../datasources/favorite_remote_datasource.dart';

class FavoriteRepository {
  final FavoriteRemoteDatasource datasource;

  FavoriteRepository(this.datasource);

  Future<void> addEventToFavorites(String userId, int eventId) {
    return datasource.addEventToFavorites(userId, eventId);
  }
}
