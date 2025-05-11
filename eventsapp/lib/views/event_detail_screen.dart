import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/event_detail_viewmodel.dart';
import '../widgets/loading_indicator.dart';

class EventDetailScreen extends ConsumerStatefulWidget {
  final int eventId;

  const EventDetailScreen({super.key, required this.eventId});

  @override
  ConsumerState<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends ConsumerState<EventDetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(eventDetailViewModelProvider.notifier).loadEvent(widget.eventId));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = ref.watch(eventDetailViewModelProvider);
    final event = state.value;

    if (state.isLoading || event == null) {
      return const Scaffold(
        body: Center(child: LoginLoading()),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          // Imagen superior
          Stack(
            children: [
              Image.network(
                event.imageUrl,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 40,
                left: 16,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: BackButton(color: theme.primaryColor),
                ),
              ),
              Positioned(
                top: 40,
                right: 16,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.favorite_border, color: theme.primaryColor),
                ),
              ),
            ],
          ),

          // Contenido
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(event.title, style: theme.textTheme.titleLarge),
                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Icon(Icons.calendar_today, size: 18, color: theme.iconTheme.color),
                        const SizedBox(width: 6),
                        Text(event.date),
                        const SizedBox(width: 16),
                        Icon(Icons.access_time, size: 18, color: theme.iconTheme.color),
                        const SizedBox(width: 6),
                        Text('${event.hora} • ${event.duracion}h'),
                      ],
                    ),
                    const SizedBox(height: 8),

                    Row(
                      children: [
                        Icon(Icons.location_on, size: 18, color: theme.iconTheme.color),
                        const SizedBox(width: 6),
                        Text(event.location),
                      ],
                    ),
                    const SizedBox(height: 20),

                    Text("Descripción", style: theme.textTheme.titleMedium),
                    const SizedBox(height: 8),
                    Text(event.description, style: theme.textTheme.bodyMedium),
                    const SizedBox(height: 20),

                    Text("Requisitos", style: theme.textTheme.titleMedium),
                    const SizedBox(height: 8),
                    Text(event.requisitos, style: theme.textTheme.bodyMedium),
                    const SizedBox(height: 20),

                    Text("Información del evento", style: theme.textTheme.titleMedium),
                    const SizedBox(height: 8),
                    _infoRow("Categoría", event.category, theme),
                    _infoRow("Precio", "\$${event.price}", theme),
                    _infoRow("Capacidad", "${event.capacidad} personas", theme),
                    _infoRow("Organizador", event.organizador, theme),
                    _infoRow("Registro requerido", event.registro ? "Sí" : "No", theme),
                    _infoRow("Etiquetas", event.etiquetas.join(", "), theme),

                    const SizedBox(height: 30),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.primaryColor,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text("Book Now"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$label: ", style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value, style: theme.textTheme.bodyMedium)),
        ],
      ),
    );
  }
}
