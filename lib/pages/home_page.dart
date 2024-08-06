import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/utils/spacer.dart';
import 'package:flutter/material.dart';

import '../services/auth/auth_service.dart';
import '../services/chat/chat_service.dart';
import '../themes/main_color.dart';
import '../widgets/my_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatService chatService = ChatService();
    final AuthService authService = AuthService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      drawer: const MyDrawer(),
      body: StreamBuilder(
        stream: chatService.getUserStream(),
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
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              if (snapshot.data.length == 0) {
                return const Center(child: Text('No Data'));
              }

              if (snapshot.data[index]['email'] !=
                  authService.getCurrentUser()!.email!) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ChatPage(
                                  receiverEmail: snapshot.data[index]['email'],
                                  receiverID: snapshot.data[index]['uid'],
                                )));
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
              }
              return const SizedBox.shrink();
            },
          );
        },
      ),
    );
  }
}
