import 'package:flutter/material.dart';

class ChatBuble extends StatelessWidget {
  const ChatBuble({
    super.key,
    required this.message,
    required this.isSender,
  });

  final String message;
  final bool isSender;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: UnconstrainedBox(
        child: Container(
            margin: const EdgeInsets.fromLTRB(16, 15, 16, 0),
            padding: const EdgeInsets.all(16),
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8),
            decoration: BoxDecoration(
                color: isSender ? Colors.green : Colors.grey,
                borderRadius: BorderRadius.circular(10)),
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            )),
      ),
    );
  }
}
