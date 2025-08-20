part of 'chat_bloc.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<ChatMessage> messages;

  ChatLoaded({required this.messages});
}

class ChatError extends ChatState {
  final String error;

  ChatError({required this.error});
}

class MessageSent extends ChatState {}
