import 'package:dartz/dartz.dart';
import 'package:domain/src/model/chat_message.dart';
import 'package:domain/src/model/error/base_error.dart';
import 'package:domain/src/repository/chat_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetMessagesUsecase {
  final ChatRepository repository;

  GetMessagesUsecase({required this.repository});

  Stream<Either<BaseError, List<ChatMessage>>> call(String chatId) {
    return repository.getMessages(chatId);
  }
}
