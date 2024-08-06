// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Mytextfield extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final FocusNode? focusNode;
  final TextEditingController controller;
  const Mytextfield({
    super.key,
    required this.hintText,
    this.obscureText = false,
    this.focusNode,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.primary)),
            enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.tertiary)),
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
            fillColor: Theme.of(context).colorScheme.secondary),
      ),
    );
  }
}