import 'package:dartz/dartz.dart';
import 'package:domain/src/model/chat_message.dart';
import 'package:domain/src/model/error/base_error.dart';
import 'package:domain/src/repository/chat_repository.dart';
import 'package:data/src/source/chat_data_source/chat_ds.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ChatRepository)
class ChatRepositoryImpl implements ChatRepository {
  final ChatDataSource chatDataSource;

  ChatRepositoryImpl({required this.chatDataSource});

  @override
  Stream<Either<BaseError, List<ChatMessage>>> getMessages(String chatId) {
    return chatDataSource.getMessages(chatId);
  }

  @override
  Future<Either<BaseError, void>> sendMessage(
      String chatId, ChatMessage message) {
    return chatDataSource.sendMessage(chatId, message);
  }
}
