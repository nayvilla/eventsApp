import 'package:flutter/material.dart';

class LoginLoading extends StatelessWidget {
  const LoginLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Obtener el tema actual

    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(theme.primaryColor), // Color del círculo
      ),
    );
  }
}
