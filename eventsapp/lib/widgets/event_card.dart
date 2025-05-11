import 'package:flutter/material.dart';
import '../models/event_model.dart';

class EventCard extends StatelessWidget {
  final EventModel event;
  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 250,
      height: 180,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: NetworkImage(event.imageUrl),
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
      ),
      child: Stack(
        children: [
          // Fondo semitransparente abajo
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.cardColor.withValues(alpha: 0.9),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          event.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.paid_rounded, color: theme.iconTheme.color, size: 20),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${event.date} – ${event.category}",
                          style: theme.textTheme.bodySmall?.copyWith(color: theme.textTheme.titleSmall?.color),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "${event.price}",
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.textTheme.titleSmall?.color,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Ícono categoría (superior izquierda)
          Positioned(
            top: 8,
            left: 8,
            child: CircleAvatar(
              radius: 14,
              backgroundColor: theme.scaffoldBackgroundColor,
              child: Icon(
                _iconForCategory(event.category),
                size: 16,
                color: theme.iconTheme.color,
              ),
            ),
          ),

          // Ícono corazón (superior derecha)
          Positioned(
            top: 8,
            right: 8,
            child: CircleAvatar(
              radius: 14,
              backgroundColor: theme.scaffoldBackgroundColor,
              child: Icon(Icons.favorite_border, size: 16, color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

IconData _iconForCategory(String category) {
  switch (category.toLowerCase()) {
    case 'comida':
      return Icons.restaurant;
    case 'tecnología':
      return Icons.computer;
    case 'arte':
      return Icons.palette;
    case 'deporte':
      return Icons.sports_soccer;
    case 'música':
      return Icons.queue_music_rounded;
    default:
      return Icons.event; // ícono por defecto
  }
}
