// lib/core/providers/add_favorite_action_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/favorite_remote_datasource.dart';
import '../../data/repositories/favorite_repository.dart';

final favoriteRepositoryProvider = Provider<FavoriteRepository>((ref) {
  return FavoriteRepository(FavoriteRemoteDatasource());
});