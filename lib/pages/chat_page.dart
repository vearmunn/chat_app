// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:chat_app/utils/spacer.dart';
import 'package:chat_app/widgets/my_textfield.dart';
import 'package:flutter/material.dart';

import '../services/auth/auth_service.dart';
import '../services/chat/chat_service.dart';
import '../widgets/chat_buble.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
    required this.receiverEmail,
    required this.receiverID,
  });

  final String receiverEmail;
  final String receiverID;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatService chatService = ChatService();

  final AuthService authService = AuthService();

  final TextEditingController messageController = TextEditingController();

  FocusNode myFocusNode = FocusNode();

  void sendMessage(context) async {
    if (messageController.text.isNotEmpty) {
      await chatService.sendMessage(
          widget.receiverID, messageController.text, context);
      messageController.clear();
      scrollDown();
    }
  }

  @override
  void initState() {
    super.initState();

    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 500), () => scrollDown());
      }
    });

    Future.delayed(const Duration(milliseconds: 500), () => scrollDown());
  }

  @override
  void dispose() {
    messageController.dispose();
    myFocusNode.dispose();
    super.dispose();
  }

  final ScrollController scrollController = ScrollController();

  void scrollDown() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverEmail),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: StreamBuilder(
              stream: chatService.getMessages(
                  widget.receiverID, authService.getCurrentUser()!.uid),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.data.docs.length == 0) {
                  return const Center(child: Text('no data'));
                }
                return ListView.builder(
                  controller: scrollController,
                  shrinkWrap: true,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    final chat = snapshot.data.docs[index];

                    if (chat['senderEmail'] ==
                        authService.getCurrentUser()!.email) {
                      return ChatBuble(
                        isSender: true,
                        message: chat['message'],
                      );
                    } else {
                      return ChatBuble(
                        isSender: false,
                        message: chat['message'],
                      );
                    }
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
            child: Row(
              children: [
                Expanded(
                  child: Mytextfield(
                    focusNode: myFocusNode,
                    controller: messageController,
                    hintText: 'Type a message...',
                  ),
                ),
                horizontalSpace(16),
                GestureDetector(
                  onTap: () {
                    sendMessage(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.green),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 2.0),
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
