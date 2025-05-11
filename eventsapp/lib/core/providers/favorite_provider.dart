// lib/core/providers/favorite_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/event_model.dart';
import '../../viewmodels/favorite_viewmodel.dart';

final favoriteEventsViewModelProvider =
    AsyncNotifierProvider<FavoriteViewModel, List<EventModel>>(
        () => FavoriteViewModel());
