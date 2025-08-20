import 'package:dartz/dartz.dart';
import 'package:domain/src/model/chat_message.dart';
import 'package:domain/src/model/error/base_error.dart';

abstract class ChatRepository {
  Stream<Either<BaseError, List<ChatMessage>>> getMessages(String chatId);

  Future<Either<BaseError, void>> sendMessage(
      String chatId, ChatMessage message);
}
