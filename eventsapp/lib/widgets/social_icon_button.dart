import 'package:flutter/material.dart';

class SocialLoginIcon extends StatelessWidget {
  final IconData icon;
  const SocialLoginIcon({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 50,
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: Icon(
          icon,
          size: theme.iconTheme.size,
          color: theme.iconTheme.color,
        ),
      ),
    );
  }
}
