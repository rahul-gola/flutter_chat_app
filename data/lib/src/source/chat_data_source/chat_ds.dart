import 'package:dartz/dartz.dart';
import 'package:domain/domain.dart';
import 'package:domain/src/model/chat_message.dart';

abstract class ChatDataSource {
  Stream<Either<BaseError, List<ChatMessage>>> getMessages(String chatId);

  Future<Either<BaseError, void>> sendMessage(
      String chatId, ChatMessage message);
}
