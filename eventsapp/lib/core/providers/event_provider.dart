// lib/core/providers/event_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/event_remote_datasource.dart';
import '../../data/repositories/event_repository.dart';

final eventDatasourceProvider = Provider((ref) => EventRemoteDatasource());
final eventRepositoryProvider = Provider((ref) => EventRepository(ref.read(eventDatasourceProvider)));
