import 'package:dartz/dartz.dart';
import 'package:data/src/network/firebase_service.dart';
import 'package:domain/src/model/chat_message.dart';
import 'chat_ds.dart';
import 'package:domain/src/model/error/base_error.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ChatDataSource)
class ChatDataSourceImpl implements ChatDataSource {
  ChatDataSourceImpl(this._firebaseService);

  final FirebaseService _firebaseService;

  @override
  Stream<Either<BaseError, List<ChatMessage>>> getMessages(String chatId) {
    return _firebaseService.getMessages(chatId);
  }

  @override
  Future<Either<BaseError, void>> sendMessage(
      String chatId, ChatMessage message) {
    return _firebaseService.sendMessage(chatId, message);
  }
}
