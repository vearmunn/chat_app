import 'package:flutter/material.dart';

import '../services/auth/auth_service.dart';
import '../services/chat/chat_service.dart';
import '../themes/main_color.dart';
import '../utils/spacer.dart';

class BlockedUsersPage extends StatelessWidget {
  const BlockedUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatService chatService = ChatService();
    final AuthService authService = AuthService();

    void unblockUser(context, String blockedUserID) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Unblock User"),
          content: const Text('Are you sure you want to unblock this user?'),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel')),
            TextButton(
                onPressed: () {
                  chatService.unblockUser(blockedUserID);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('User unblocked!')));
                },
                child: const Text('Unblock'))
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Blocked Users'),
      ),
      body: StreamBuilder(
        stream: chatService
            .getBlockedUsersStream(authService.getCurrentUser()!.uid),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data.length == 0) {
            return const Center(child: Text('No blocked users'));
          }
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => Wrap(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.block_flipped),
                          title: const Text('Unblock User'),
                          onTap: () {
                            Navigator.pop(context);
                            unblockUser(context, snapshot.data[index]['uid']);
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
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: secondary(context),
                        borderRadius: BorderRadius.circular(12)),
                    margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        const Icon(Icons.person),
                        horizontalSpace(16),
                        Text(snapshot.data[index]['email']),
                      ],
                    )),
              );
            },
          );
        },
      ),
    );
  }
}
