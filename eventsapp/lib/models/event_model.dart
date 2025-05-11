// lib/models/event_model.dart

class EventModel {
  final int id;
  final String title;
  final String date;
  final String hora;
  final int duracion;
  final String category;
  final double price;
  final int capacidad;
  final String organizador;
  final List<String> etiquetas;
  final String imageUrl;
  final bool destacado;
  final String requisitos;
  final bool registro;
  final String description;
  final String location;

  EventModel({
    required this.id,
    required this.title,
    required this.date,
    required this.hora,
    required this.duracion,
    required this.category,
    required this.price,
    required this.capacidad,
    required this.organizador,
    required this.etiquetas,
    required this.imageUrl,
    required this.destacado,
    required this.requisitos,
    required this.registro,
    required this.description,
    required this.location,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      title: json['title'],
      date: json['date'],
      hora: json['hora'],
      duracion: json['duracion'],
      category: json['category'],
      price: (json['price'] as num).toDouble(),
      capacidad: json['capacidad'],
      organizador: json['organizador'],
      etiquetas: List<String>.from(json['etiquetas']),
      imageUrl: json['imageUrl'],
      destacado: json['destacado'],
      requisitos: json['requisitos'],
      registro: json['registro'],
      description: json['description'],
      location: json['location'],
    );
  }
}
