import 'package:dartz/dartz.dart';
import 'package:domain/src/model/chat_message.dart';
import 'package:domain/src/model/error/base_error.dart';
import 'package:domain/src/model/user_data.dart';
import 'package:domain/src/repository/auth/auth_repository.dart';
import 'package:domain/src/repository/chat_repository.dart';
import 'package:domain/src/usecase/base/base_usecase.dart';
import 'package:domain/src/usecase/base/params.dart';
import 'package:injectable/injectable.dart';


@injectable
class SendMessageUsecase extends BaseUseCase<SendMessageParams, void> {
  SendMessageUsecase(this.repository);

  final ChatRepository repository;

  @override
  Future<Either<BaseError, void>> execute(SendMessageParams params) {
    return repository.sendMessage(params.chatId, params.message);
  }
}

class SendMessageParams extends Params {
  SendMessageParams({required this.chatId, required this.message});

  final String chatId;
  final ChatMessage message;
}
