// lib/viewmodels/event_detail_viewmodel.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/event_model.dart';
import '../core/providers/event_provider.dart';

class EventDetailViewModel extends AsyncNotifier<EventModel?> {
  late final int eventId;

  @override
  Future<EventModel?> build() async {
    // Se espera que setEventId() se llame antes de usar build
    return null;
  }

  Future<void> loadEvent(int id) async {
    state = const AsyncLoading();
    final repo = ref.read(eventRepositoryProvider);

    try {
      final event = await repo.getEventById(id);
      state = AsyncData(event);
    } catch (e) {
      state = AsyncError(e.toString(), StackTrace.current);
    }
  }
}

final eventDetailViewModelProvider =
    AsyncNotifierProvider<EventDetailViewModel, EventModel?>(() => EventDetailViewModel());
