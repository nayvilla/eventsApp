import 'package:flutter/material.dart';

class PackageCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  const PackageCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardColor, // Fondo del contenedor usando el color del tema
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              // Icono dentro de un contenedor con fondo
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.primaryColor, // Color de fondo usando el color primario
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8), // Bordes redondeados
                ),
                child: Icon(icon, size: 30), // Icono usando el color primario
              ),
              const SizedBox(width: 12),
              // Título y valor
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    value,
                    style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
