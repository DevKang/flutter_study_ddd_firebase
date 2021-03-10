import 'package:dartz/dartz.dart';
import 'package:flutter_ddd_firebase/domain/auth/auth_failure.dart';
import 'package:flutter_ddd_firebase/domain/auth/user.dart';
import 'package:flutter_ddd_firebase/domain/auth/value_objects.dart';

abstract class IAuthFacade {
  Future<AppUser?> getSignedUser();

  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword(
    EmailAddress emailAddress,
    Password password,
  );

  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword(
    EmailAddress emailAddress,
    Password password,
  );

  Future<Either<AuthFailure, Unit>> signInWithGoogle();

  Future<void> signOut();
}
