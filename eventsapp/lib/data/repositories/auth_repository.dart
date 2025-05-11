import '../datasources/auth_remote_datasource.dart';
import '../../models/user_model.dart';

/// Repositorio de autenticación que consume la fuente de datos remota.
/// Expone métodos de login y registro a la capa de ViewModel.
class AuthRepository {
  final AuthRemoteDatasource remoteDatasource;

  AuthRepository(this.remoteDatasource);

  /// Inicia sesión llamando al datasource
  Future<UserModel> login(String email, String password) {
    return remoteDatasource.login(email, password);
  }

  /// Registra un nuevo usuario
  Future<UserModel> register(String nombre, String email, String password) {
    return remoteDatasource.register(nombre, email, password);
  }
}
