
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/api_constants.dart';

class FavoriteRemoteDatasource {
  Future<void> addEventToFavorites(String userId, int eventId) async {
  final url = Uri.parse(ApiConstants.userFavorites(userId));

  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'eventId': eventId}),
  );

  if (response.statusCode != 200 && response.statusCode != 201) {
    throw Exception('No se pudo agregar el evento a favoritos');
  }
}
}

