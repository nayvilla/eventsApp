import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository.dart';

final authRemoteDatasourceProvider = Provider((ref) => AuthRemoteDatasource());

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(ref.read(authRemoteDatasourceProvider)),
);
