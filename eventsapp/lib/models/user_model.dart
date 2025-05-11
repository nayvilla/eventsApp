class UserModel {
  final int id;
  final String nombre;
  final String email;
  final String password;
  final List<int> favorites;

  UserModel({
    required this.id,
    required this.nombre,
    required this.email,
    required this.password,
    required this.favorites,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      nombre: json['nombre'],
      email: json['email'],
      password: json['password'],
      favorites: List<int>.from(json['favorites']),
    );
  }
}
