// lib/data/event_remote_datasource.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/api_constants.dart';
import '../../models/event_model.dart';

/// Clase responsable de consumir eventos desde el backend.
class EventRemoteDatasource {
  /// Obtiene todos los eventos del backend.
  Future<List<EventModel>> getAllEvents() async {
    final response = await http.get(Uri.parse(ApiConstants.events));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => EventModel.fromJson(e)).toList();
    } else {
      throw Exception('No se pudieron cargar los eventos');
    }
  }

  /// Obtiene eventos filtrados por una categoría específica.
  Future<List<EventModel>> getEventsByCategory(String category) async {
    final url = '${ApiConstants.eventsByCategory}$category';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => EventModel.fromJson(e)).toList();
    } else {
      throw Exception('No se pudieron cargar los eventos de la categoría $category');
    }
  }

  /// Obtiene eventos filtrados por id
  Future<EventModel> getEventById(int id) async {
  final response = await http.get(Uri.parse(ApiConstants.eventById(id.toString())));

  if (response.statusCode == 200) {
    final Map<String, dynamic> json = jsonDecode(response.body);
    return EventModel.fromJson(json);
  } else {
    throw Exception('Error al obtener el evento con ID $id');
  }
}

}
