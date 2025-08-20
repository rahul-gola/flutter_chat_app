import 'package:dartz/dartz.dart';
import 'package:domain/src/model/error/base_error.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:domain/src/model/chat_message.dart';
import 'package:domain/src/usecase/send_message_usecase.dart';
import 'package:domain/src/usecase/get_messages_usecase.dart';

part 'chat_event.dart';
part 'chat_state.dart';

@injectable
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final SendMessageUsecase sendMessageUsecase;
  final GetMessagesUsecase getMessagesUsecase;

  Stream<Either<BaseError, List<ChatMessage>>>? messageStream;

  ChatBloc({required this.sendMessageUsecase, required this.getMessagesUsecase})
    : super(ChatInitial()) {
    on<LoadMessagesEvent>(_onLoadMessages);
    on<SendMessageEvent>(_onSendMessage);
  }

  Future<void> _onLoadMessages(LoadMessagesEvent event,
      Emitter<ChatState> emit) async {
    emit(ChatLoading());
    await emit.forEach<Either<BaseError, List<ChatMessage>>>(
      getMessagesUsecase(event.chatId),
      onData: (result) =>
          result.fold(
                (error) => ChatError(error: error.message),
                (messages) => ChatLoaded(messages: messages),
          ),
      onError: (_, __) => ChatError(error: "Unknown error"),
    );
  }

  Future<void> _onSendMessage(
    SendMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
    final chatMessage = ChatMessage(
      id: '',
      // id is assigned by Firestore, unused when sending
      senderId: event.senderId,
      receiverId: event.receiverId,
      message: event.message,
      timestamp: DateTime.now(),
    );
    final result = await sendMessageUsecase(event.chatId, chatMessage);
    result.fold(
      (error) => emit(ChatError(error: error.message)),
      (_) => emit(MessageSent()),
    );
  }
}
