part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

class LoadMessagesEvent extends ChatEvent {
  final String chatId;

  LoadMessagesEvent({required this.chatId});
}

class SendMessageEvent extends ChatEvent {
  final String chatId;
  final String message;
  final String senderId;
  final String receiverId;

  SendMessageEvent({
    required this.chatId,
    required this.message,
    required this.senderId,
    required this.receiverId,
  });
}
