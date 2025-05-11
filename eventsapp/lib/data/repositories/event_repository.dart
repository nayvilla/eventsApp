// lib/data/repositories/event_repository.dart
import '../datasources/event_remote_datasource.dart';
import '../../models/event_model.dart';

class EventRepository {
  final EventRemoteDatasource datasource;

  EventRepository(this.datasource);

  Future<List<EventModel>> getAllEvents() {
    return datasource.getAllEvents();
  }

  Future<List<EventModel>> getEventByCategory(String category) {
    return datasource.getEventsByCategory(category);
  }

  Future<EventModel> getEventById(int id) {
    return datasource.getEventById(id);
  }
}
