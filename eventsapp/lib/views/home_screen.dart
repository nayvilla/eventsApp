import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../viewmodels/event_viewmodel.dart';
import '../../widgets/event_card.dart';
import '../../widgets/category_button.dart';
import '../core/providers/theme_provider.dart';
import '../../viewmodels/auth_viewmodel.dart';
import '../routes/app_routes.dart';
import '../widgets/loading_indicator.dart';


class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String _selectedCategory = "Todos";
  String _searchTerm = "";

  void _onCategorySelected(String category) {
    setState(() => _selectedCategory = category);
  }

  void _onSearchChanged(String value) {
    setState(() => _searchTerm = value.toLowerCase());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final eventsAsync = ref.watch(eventViewModelProvider);
    final themeNotifier = ref.read(themeProvider.notifier);
    final currentMode = themeNotifier.currentMode;
    final userAsync = ref.watch(authViewModelProvider);
    final userName = userAsync.value?.nombre ?? "Invitado";

    IconData icon;
    switch (currentMode) {
      case AppThemeMode.light:
        icon = Icons.light_mode;
        break;
      case AppThemeMode.dark:
        icon = Icons.dark_mode;
        break;
      case AppThemeMode.viu:
        icon = Icons.color_lens;
        break;
    }

    final Map<String, IconData> categoryIcons = {
      "Todos": Icons.view_list,
      "Música": Icons.queue_music_rounded,
      "Deporte": Icons.sports_soccer,
      "Comida": Icons.restaurant,
      "Arte": Icons.palette,
      "Tecnología": Icons.computer,
    };

    String welcomeMessage = "Bienvenido 👋\n$userName";
    int maxLength = 37;
    bool navigating = false;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: theme.primaryColor,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Calendario'),
          BottomNavigationBarItem(icon: Icon(Icons.headphones), label: 'Audio'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: eventsAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text(e.toString())),
                data: (events) {
                  final filteredEvents = events.where((event) {
                    final matchesCategory = _selectedCategory == "Todos" || event.category.toLowerCase() == _selectedCategory.toLowerCase();
                    final matchesSearch = event.title.toLowerCase().contains(_searchTerm);
                    return matchesCategory && matchesSearch;
                  }).toList();
            
                  final popularEvents = filteredEvents.where((e) => e.destacado).toList();
                  final recommendedEvents = filteredEvents.where((e) => !e.destacado).toList();
            
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Bienvenida y cambio de tema
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(welcomeMessage.length > maxLength 
                              ? welcomeMessage.substring(0, maxLength) 
                              : welcomeMessage, 
                              style: theme.textTheme.titleLarge
                            ),
                            GestureDetector(
                              onTap: () {
                                final nextMode = {
                                  AppThemeMode.viu: AppThemeMode.light,
                                  AppThemeMode.light: AppThemeMode.dark,
                                  AppThemeMode.dark: AppThemeMode.viu,
                                }[currentMode]!;
                                themeNotifier.setTheme(nextMode);
                              },
                              child: CircleAvatar(
                                backgroundColor: theme.cardColor,
                                child: Icon(icon, color: theme.primaryColor),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
            
                        // Buscador
                        TextField(
                          onChanged: _onSearchChanged,
                          decoration: InputDecoration(
                            hintText: "Buscar evento...",
                            prefixIcon: const Icon(Icons.search),
                            filled: true,
                            fillColor: theme.cardColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
            
                        // Botones de categoría
                        Text("Categoría", style: theme.textTheme.titleMedium),
                        const SizedBox(height: 12),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              for (var cat in ["Todos", "Música", "Deporte", "Comida", "Arte", "Tecnología"]) ...[
                                CategoryButton(
                                  label: cat,
                                  icon: categoryIcons[cat]!,
                                  isSelected: _selectedCategory == cat,
                                  onTap: () => _onCategorySelected(cat),
                                ),
                                const SizedBox(width: 8),
                              ]
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
            
                        Text("Eventos Destacados", style: theme.textTheme.titleMedium),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 200,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: popularEvents.length,
                            itemBuilder: (_, i) => GestureDetector(
                              onTap: () async {
                                setState(() => navigating = true);
                                await Navigator.pushNamed(context, AppRoutes.eventDetail, arguments: popularEvents[i].id);
                                if (mounted) {
                                  setState(() => navigating = false);
                                }
                              },
                              child: EventCard(event: popularEvents[i])
                            ),
                          ),
                        ),
            
                        const SizedBox(height: 24),
            
                        Text("Eventos Disponibles", style: theme.textTheme.titleMedium),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 200,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: recommendedEvents.length,
                            itemBuilder: (_, i) => GestureDetector(
                              onTap: () async {
                                setState(() => navigating = true);
                                await Navigator.pushNamed(context, AppRoutes.eventDetail, arguments: recommendedEvents[i].id);
                                if (mounted) {
                                  setState(() => navigating = false);
                                }
                              },
                              child: EventCard(event: recommendedEvents[i])
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            if (navigating)
              Positioned.fill(
                child: ColoredBox(
                  color: Colors.black38,
                  child: Center(child: LoginLoading()),
                ),
              ),
          ],
        ),
      ),
    );
  }
}


