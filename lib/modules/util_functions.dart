import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text, String type) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: (type == "error")
          ? Color.fromARGB(255, 255, 103, 92)
          : Color.fromARGB(255, 75, 165, 78),
      content: Text(text, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
      duration: const Duration(seconds: 3), // Duration for which snackbar is visible
      action: SnackBarAction(
        label: 'Close', // Label for the action
        textColor : Color.fromARGB(255, 219, 230, 255),
        onPressed: () {
          // Action when pressed
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    ),
  );
}