// lib/viewmodels/event_viewmodel.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/event_model.dart';
import '../core/providers/event_provider.dart';

class EventViewModel extends AsyncNotifier<List<EventModel>> {
  @override
  Future<List<EventModel>> build() async {
    final repo = ref.read(eventRepositoryProvider);
    return await repo.getAllEvents();
  }

  Future<void> fetchByCategory(String category) async {
    state = const AsyncLoading();
    final repo = ref.read(eventRepositoryProvider);

    try {
      final filtered = await repo.getEventByCategory(category);
      state = AsyncData(filtered);
    } catch (e) {
      state = AsyncError(e.toString(), StackTrace.current);
    }
  }
}

final eventViewModelProvider =
    AsyncNotifierProvider<EventViewModel, List<EventModel>>(() => EventViewModel());
