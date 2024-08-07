// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class ChatBuble extends StatelessWidget {
  const ChatBuble({
    super.key,
    required this.message,
    required this.isSender,
    required this.messageID,
    required this.userID,
  });

  final String message;
  final bool isSender;
  final String messageID;
  final String userID;

  void showOptions(context, String messageID, String userID) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.flag),
            title: const Text('Report'),
            onTap: () {
              reportUser(context, messageID, userID);
            },
          ),
          ListTile(
            leading: const Icon(Icons.block),
            title: const Text('Block'),
            onTap: () {
              blockUser(context, userID);
            },
          ),
          ListTile(
            leading: const Icon(Icons.cancel),
            title: const Text('Cancel'),
            onTap: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  reportUser(context, String messageID, String userID) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Report Message'),
        content: const Text('Are you sure you want to report this message?'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel')),
          TextButton(
              onPressed: () {
                ChatService().reportUser(messageID, userID);
                Navigator.pop(context);
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Message reported!')));
              },
              child: const Text('Report')),
        ],
      ),
    );
  }

  blockUser(context, String userID) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Block User'),
        content: const Text('Are you sure you want to block this user?'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel')),
          TextButton(
              onPressed: () {
                ChatService().blockUser(userID);
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('User blocked!')));
              },
              child: const Text('Block')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onLongPress: () {
          if (!isSender) {
            showOptions(context, messageID, userID);
          }
        },
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
      ),
    );
  }
}
