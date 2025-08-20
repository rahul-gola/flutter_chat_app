part of 'chat_bloc.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  ChatLoaded({required this.messages});
  final List<ChatMessage> messages;
}

class ChatError extends ChatState {
  ChatError({required this.error});
  final String error;
}

class MessageSent extends ChatState {}
