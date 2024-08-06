import 'package:flutter/material.dart';

void showCustomDialog(String message, context) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text(message),
          ));
}
