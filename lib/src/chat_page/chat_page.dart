import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_app/core/di/di.dart';
import 'package:intl/intl.dart';
import 'bloc/chat_bloc.dart';
import 'package:domain/src/model/chat_message.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    required this.receiverEmail,
    required this.receiverUid,
    required this.senderUid,
    super.key,
  });
  final String receiverEmail;
  final String receiverUid;
  final String senderUid;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final bloc = getIt<ChatBloc>();
  final TextEditingController _messageController = TextEditingController();
  late final String chatId;

  @override
  void initState() {
    super.initState();
    final ids = [widget.senderUid, widget.receiverUid];
    ids.sort();
    chatId = ids.join('_');
    bloc.add(LoadMessagesEvent(chatId: chatId));
  }

  void sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;
    bloc.add(
      SendMessageEvent(
        chatId: chatId,
        message: text,
        senderId: widget.senderUid,
        receiverId: widget.receiverUid,
      ),
    );
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.receiverEmail)),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              bloc: bloc,
              builder: (context, state) {
                if (state is ChatLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ChatLoaded) {
                  final messages = state.messages;
                  return ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final ChatMessage message = messages[index];
                      final isMe = message.senderId == widget.senderUid;
                      return ChatMessageWidget(
                        message: message.message,
                        isMe: isMe,
                        time: message.timestamp,
                      );
                    },
                  );
                } else if (state is ChatError) {
                  return Center(child: Text(state.error));
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            color: Colors.grey[100],
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blue),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Stateless widget to display a chat message
class ChatMessageWidget extends StatelessWidget {
  const ChatMessageWidget({
    required this.message,
    required this.isMe,
    required this.time,
    super.key,
  });
  final String message;
  final bool isMe;
  final DateTime time;

  @override
  Widget build(BuildContext context) {
    final formattedTime =
        '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMe ? Colors.blue[100] : const Color(0xf1f1f1f1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: isMe
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Text(message, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 4),
            Text(
              formattedTime,
              style: TextStyle(fontSize: 9, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
