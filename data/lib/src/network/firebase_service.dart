import 'package:dartz/dartz.dart';
import 'package:domain/domain.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FirebaseService {
  final _firebaseAuth = FirebaseAuth.instance;

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
          email: user.email ?? '',
          displayName: user.displayName ?? '',
          photoUrl: user.photoURL ?? '',
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
            email: user.email ?? '',
            displayName: user.displayName ?? '',
            photoUrl: user.photoURL ?? '',
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

  Stream<Either<BaseError, List<UserDataModel>>> getAllUsers() {
    return FirebaseFirestore.instance
        .collection('users')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map<Either<BaseError, List<UserDataModel>>>((snapshot) {
      try {
        final users = snapshot.docs
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
}
