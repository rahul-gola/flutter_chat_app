import 'package:dartz/dartz.dart';
import 'package:domain/domain.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:domain/src/model/chat_message.dart';

@lazySingleton
class FirebaseService {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<Either<BaseError, UserDataModel>> getUserSignUp(
    String email,
    String password,
    String name,
  ) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user;
      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'name': name,
          'uid': user.uid,
          'email': user.email,
          'createdAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));

        return Right(
          UserDataModel(
            uid: user.uid,
            email: email ?? '',
            displayName: name,
            createdAt: '',
          ),
        );
      } else {
        return Left(
          BaseError(
            message: 'FirebaseAuthException',
            cause: Exception('Could not register user'),
          ),
        );
      }
    } on FirebaseAuthException catch (exception) {
      return Left(
        BaseError(
          message: exception.message ?? 'FirebaseAuthException',
          cause: exception,
        ),
      );
    }
  }

  Future<Either<BaseError, UserDataModel>> getUserSignIn(
    String email,
    String password,
  ) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user;
      if (user == null) throw Exception('Email/Password is incorrect');
      return Right(
        UserDataModel(
          uid: user.uid,
          email: email,
          displayName: '',
          createdAt: '',
        ),
      );
    } on FirebaseAuthException catch (exception) {
      return Left(
        BaseError(
          message: exception.message ?? 'FirebaseAuthException',
          cause: exception,
        ),
      );
    }
  }

  Future<Either<BaseError, UserDataModel>> getCurrentUserName() async {
    try {
      if (FirebaseAuth.instance.currentUser == null) {
        return Left(BaseError(
          message: 'No user logged in',
          cause: Exception(
            'No user logged in',
          ),
        ));
      }

      final doc = await _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();
      if (doc.exists && doc.data() != null) {
        final data = doc.data()!;
        return Right(UserDataModel.fromJson(data));
      } else {
        return Left(BaseError(
          message: 'User document does not exist',
          cause: Exception('User document does not exist'),
        ));
      }
    } on FirebaseAuthException catch (exception) {
      return Left(BaseError(message: 'Unexpected error', cause: exception));
    }
  }

  Stream<Either<BaseError, List<UserDataModel>>> getAllUsers() {
    return _firestore
        .collection('users')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map<Either<BaseError, List<UserDataModel>>>((snapshot) {
      try {
        final users = snapshot.docs
            .where((doc) =>
                doc.data()['uid'] != FirebaseAuth.instance.currentUser?.uid)
            .map((doc) => UserDataModel.fromJson(doc.data()))
            .toList();
        return Right(users);
      } catch (exception) {
        return Left(
          BaseError(
            message: 'Error while parsing users',
            cause: Exception('Error while parsing users'),
          ),
        );
      }
    }).handleError((error, stackTrace) {
      if (error is FirebaseException) {
        return Left(
          BaseError(
            message: error.message ?? 'FirebaseException',
            cause: error,
          ),
        );
      }
      return Left(
        BaseError(
          message: 'Unexpected error while fetching users',
          cause: error,
        ),
      );
    });
  }

  Future<Either<BaseError, bool>> signOutUser() async {
    try {
      await _firebaseAuth.signOut();
      return const Right(true);
    } on FirebaseAuthException catch (exception) {
      return Left(BaseError(message: 'Sign out failed', cause: exception));
    }
  }

  // Send a message
  Future<Either<BaseError, void>> sendMessage(
      String chatId, ChatMessage message) async {
    try {
      await _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .add({
        'senderId': message.senderId,
        'receiverId': message.receiverId,
        'message': message.message,
        'timestamp': message.timestamp.toIso8601String(),
      });
      return const Right(null);
    } catch (e) {
      return Left(
          BaseError(message: 'Failed to send message', cause: Exception(e)));
    }
  }

  // Stream messages by chatId
  Stream<Either<BaseError, List<ChatMessage>>> getMessages(String chatId) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots()
        .map<Either<BaseError, List<ChatMessage>>>((snapshot) {
      try {
        final messages = snapshot.docs.map((doc) {
          final data = doc.data();
          dynamic ts = data['timestamp'];
          DateTime timestamp;
          if (ts is String) {
            timestamp = DateTime.parse(ts);
          } else if (ts is Timestamp) {
            timestamp = ts.toDate();
          } else {
            timestamp = DateTime.now();
          }
          return ChatMessage(
            id: doc.id,
            senderId: data['senderId'] as String,
            receiverId: data['receiverId'] as String,
            message: data['message'] as String,
            timestamp: timestamp,
          );
        }).toList();
        return Right(messages);
      } catch (e) {
        return Left(
            BaseError(message: 'Failed to load messages', cause: Exception(e)));
      }
    });
  }
}
