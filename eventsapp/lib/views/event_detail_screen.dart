import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/providers/favorite_provider.dart';
import '../routes/app_routes.dart';
import '../viewmodels/add_favorite_action_viewmodel.dart';
import '../viewmodels/auth_viewmodel.dart';
import '../viewmodels/event_detail_viewmodel.dart';
import '../widgets/custom_snackbar.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/package_card.dart';

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
    final user = ref.watch(authViewModelProvider).value;
    final addState = ref.watch(favoriteActionViewModelProvider); 
    final addNotifier = ref.read(favoriteEventsViewModelProvider.notifier);

    if (state.isLoading || event == null || addState.isLoading) {
      return const Scaffold(
        body: Center(child: LoginLoading()),
      );
    }

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // estamos en la segunda pantalla
        selectedItemColor: theme.primaryColor,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, AppRoutes.home);
              break;
            case 1:
              Navigator.pushNamed(context, AppRoutes.calendar);
              break;
            case 2:
              Navigator.pushNamed(context, AppRoutes.favorite);
              break;
            case 3:
              Navigator.pushNamed(context, AppRoutes.profile);
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Calendario'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favoritos'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
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
                alignment: Alignment.topCenter,
              ),
              Positioned(
                top: 40,
                left: 16,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: CircleAvatar(
                    backgroundColor: theme.scaffoldBackgroundColor,
                    child: Icon(Icons.arrow_back),
                  ),
                ),
              ),

              Positioned(
                top: 40,
                right: 16,
                child: GestureDetector(
                  onTap: () async {
                    await ref.read(favoriteActionViewModelProvider.notifier).addToFavorites((user?.id ?? 1).toString(), event.id);
                    await addNotifier.reloadUserFavorities((user?.id ?? 1).toString());
                    showCustomSnackBar(context, 'Evento añadido a favoritos', true);
                  },
                  child: CircleAvatar(
                    backgroundColor: theme.scaffoldBackgroundColor,
                    child: Icon(Icons.favorite_border),
                  ),
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
                    const SizedBox(height: 8),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                      children: event.etiquetas.map((tag) {
                        return Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                          decoration: BoxDecoration(
                            color: theme.cardColor, // Fondo con opacidad ligera
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            tag, // Muestra la etiqueta
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 18),

                    Text("Requisitos", style: theme.textTheme.titleMedium),
                    const SizedBox(height: 8),
                    Text(event.requisitos, style: theme.textTheme.bodyMedium),
                    const SizedBox(height: 20),

                    Text("Información del evento", style: theme.textTheme.titleMedium),
                    const SizedBox(height: 8),
                    PackageCard(
                      label: "Categoría",
                      value: event.category,
                      icon: Icons.category,
                    ),
                    PackageCard(
                      label: "Precio",
                      value: "\$${event.price}",
                      icon: Icons.attach_money,
                    ),
                    PackageCard(
                      label: "Capacidad",
                      value: "${event.capacidad} personas",
                      icon: Icons.people,
                    ),
                    PackageCard(
                      label: "Organizador",
                      value: event.organizador,
                      icon: Icons.person,
                    ),
                    PackageCard(
                      label: "Registro requerido",
                      value: event.registro ? "Sí" : "No",
                      icon: Icons.check_box,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
