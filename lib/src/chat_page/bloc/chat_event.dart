part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

class LoadMessagesEvent extends ChatEvent {
  LoadMessagesEvent({required this.chatId});
  final String chatId;
}

class SendMessageEvent extends ChatEvent {
  SendMessageEvent({
    required this.chatId,
    required this.message,
    required this.senderId,
    required this.receiverId,
  });
  final String chatId;
  final String message;
  final String senderId;
  final String receiverId;
}
