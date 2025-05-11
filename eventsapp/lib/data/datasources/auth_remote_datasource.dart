import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../core/constants/api_constants.dart';
import '../../models/user_model.dart';

/// Fuente de datos remota para operaciones de autenticación.
/// Se conecta con el backend usando HTTP.
class AuthRemoteDatasource {
  /// Inicia sesión con email y contraseña.
  /// Retorna un `UserModel` si es exitoso, lanza un error si falla.
  Future<UserModel> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.login),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return UserModel.fromJson(body);
      } else if (response.statusCode == 401) {
        throw Exception('Credenciales incorrectas');
      } else if (response.statusCode == 500) {
        final mensaje = body['message'] ?? 'Ocurrio un error inesperado, intenta mas tarde'; //Error interno del servidor
        throw Exception('Error del servidor: $mensaje');
      } else {
        final mensaje = body['error'] ?? 'Ocurrio un error inesperado, intenta mas tarde'; //Error inesperado
        throw Exception(mensaje);
      }
    } catch (e) {
      throw Exception('Ocurrio un error inesperado, intenta mas tarde: $e'); // Error de conexión o de otro tipo
    }
  }

  // Registra un nuevo usuario con nombre, email y contraseña.
  Future<UserModel> register(String nombre, String email, String password) async {
    final response = await http.post(
      Uri.parse(ApiConstants.register),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nombre': nombre,
        'email': email,
        'password': password,
      }),
    );

    try {
      final body = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return UserModel.fromJson(body);
      } else {
        final error = body['message'] ?? body['error'] ?? 'Error inesperado';
        throw Exception(error);
      }
    } catch (e) {
      // Errores de parsing o fallos de respuesta
      throw Exception("Error al procesar la respuesta del servidor");
    }
  }
}
