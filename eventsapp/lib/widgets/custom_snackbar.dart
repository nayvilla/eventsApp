import 'package:flutter/material.dart';

void showCustomSnackBar(BuildContext context, String message, bool isSuccess) {
  final icon = isSuccess ? Icons.check_circle : Icons.error;
  final color = isSuccess ? Colors.green.shade300 : Colors.red.shade300;

  final snackBar = SnackBar(
    content: Row(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            message,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
    backgroundColor: color,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(10),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

