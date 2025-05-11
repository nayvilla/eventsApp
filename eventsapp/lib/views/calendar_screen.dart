import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import '../viewmodels/event_viewmodel.dart';
import '../models/event_model.dart';
import '../routes/app_routes.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final eventsAsync = ref.watch(eventViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendario de Eventos'),
        backgroundColor: theme.primaryColor,
        foregroundColor: theme.appBarTheme.foregroundColor,
      ),
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
      body: eventsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
        data: (events) {
          final eventMap = <DateTime, List<EventModel>>{};

          for (final e in events) {
            final eventDate = DateTime.parse(e.date);
            eventMap.putIfAbsent(eventDate, () => []).add(e);
          }

          return Column(
            children: [
              TableCalendar<EventModel>(
                firstDay: DateTime.utc(2020),
                lastDay: DateTime.utc(2030),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: theme.primaryColor.withAlpha(100),
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: theme.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  markerDecoration: BoxDecoration(
                    color: theme.colorScheme.secondary,
                    shape: BoxShape.circle,
                  ),
                ),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleTextStyle: theme.textTheme.titleMedium!,
                  titleCentered: true,
                ),
                eventLoader: (day) => eventMap[DateTime(day.year, day.month, day.day)] ?? [],
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    for (final event in eventMap[DateTime(
                          _selectedDay?.year ?? _focusedDay.year,
                          _selectedDay?.month ?? _focusedDay.month,
                          _selectedDay?.day ?? _focusedDay.day,
                        )] ?? [])
                      Card(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: theme.primaryColor.withAlpha(30),
                            child: Icon(Icons.event, color: theme.iconTheme.color),
                          ),
                          title: Text(event.title, style: theme.textTheme.titleMedium),
                          subtitle: Text("${event.hora} • ${event.location}"),
                        ),
                      ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
