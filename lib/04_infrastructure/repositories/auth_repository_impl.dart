

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tirolevents/04_infrastructure/extensions/firebase_user_mapper.dart';
import '../../03_domain/entities/user.dart';
import '../../03_domain/repositories/auth_repository.dart';
import '../../core/failures/auth_failures.dart';


class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth firebaseAuth;

  AuthRepositoryImpl({required this.firebaseAuth});

  @override
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return left(EmailAlreadyInUseFailure());
      } else {
        return left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == "wrong-password" || e.code == "user-not-found") {
        return left(InvalidEmailAndPasswordCombinationFailure());
      } else {
        return left(ServerFailure());
      }
    }
  }

  @override
  Future<void> signOut() => Future.wait([
    firebaseAuth.signOut(),
  ]);

  @override
  Option<CustomUser> getSignedInUser() =>
      optionOf(firebaseAuth.currentUser?.toDomain());
}