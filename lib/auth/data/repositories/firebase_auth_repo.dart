import 'dart:developer';

import 'package:climate_confluence/auth/data/models/auth_failure.dart';
import 'package:climate_confluence/auth/data/models/auth_user.dart';
import 'package:climate_confluence/common/data/models/value_objects.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class FirebaseAuthRepo {
  FirebaseAuthRepo({
    required FirebaseAuth firebaseAuth,
    required GoogleSignIn googleSignIn,
  })  : _firebaseAuth = firebaseAuth,
        _googleSignIn = googleSignIn;

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  Option<AuthUser> getSignedInUser() {
    final user = _firebaseAuth.currentUser;
    return _firebaseAuth.currentUser != null
        ? some(
            AuthUser(
              id: UniqueId.fromUniqueString(
                user!.uid,
              ),
              name: user.displayName != null ? Name(user.displayName!) : null,
              email: EmailAddress(user.email!),
              isEmailVerified: user.emailVerified,
              photoUrl: user.photoURL != null ? Url(user.photoURL!) : null,
            ),
          )
        : none();
  }

  Future<Either<AuthFailure, AuthUser>> registerWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: emailAddress.getOrCrash(),
        password: password.getOrCrash(),
      );
      final user = credential.user;
      if (user == null) {
        return left(const AuthFailure.serverError());
      }

      final authUser = AuthUser(
        id: UniqueId.fromUniqueString(user.uid),
        name: user.displayName != null ? Name(user.displayName!) : null,
        email: EmailAddress(user.email!),
        isEmailVerified: user.emailVerified,
        photoUrl: user.photoURL != null ? Url(user.photoURL!) : null,
      );

      return authUser.failureOption.fold(
        () => right(authUser),
        (failure) => failure.maybeMap(
          orElse: () => left(const AuthFailure.serverError()),
        ),
      );
    } on FirebaseAuthException catch (e) {
      return left(_handleFirebaseAuthException(e));
    } on PlatformException catch (e) {
      return left(_handlePlatformException(e));
    }
  }

  Future<Either<AuthFailure, Unit>> sendEmailVerification() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        return left(const AuthFailure.serverError());
      }

      await user.sendEmailVerification();
      return right(unit);
    } on FirebaseAuthException catch (e) {
      return left(_handleFirebaseAuthException(e));
    } on PlatformException catch (e) {
      return left(_handlePlatformException(e));
    }
  }

  Stream<Either<AuthFailure, AuthUser>> get onAuthStateChanged {
    return _firebaseAuth.userChanges().map(
      (user) {
        if (user == null) {
          return left(const AuthFailure.userNotFound());
        }

        final authUser = AuthUser(
          id: UniqueId.fromUniqueString(user.uid),
          name: user.displayName != null ? Name(user.displayName!) : null,
          email: EmailAddress(user.email!),
          isEmailVerified: user.emailVerified,
          photoUrl: user.photoURL != null ? Url(user.photoURL!) : null,
        );

        log(authUser.failureOption.toString());

        return authUser.failureOption.fold(
          () => right(authUser),
          (failure) => failure.maybeMap(
            orElse: () => left(const AuthFailure.serverError()),
          ),
        );
      },
    );
  }

  Future<Either<AuthFailure, Unit>> sendPasswordResetEmail({
    required EmailAddress emailAddress,
  }) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(
        email: emailAddress.getOrCrash(),
      );
      return right(unit);
    } on FirebaseAuthException catch (e) {
      return left(_handleFirebaseAuthException(e));
    } on PlatformException catch (e) {
      return left(_handlePlatformException(e));
    }
  }

  Future<Either<AuthFailure, Unit>> confirmPasswordReset({
    required String code,
    required Password newPassword,
  }) async {
    try {
      await _firebaseAuth.confirmPasswordReset(
        code: code,
        newPassword: newPassword.getOrCrash(),
      );
      return right(unit);
    } on FirebaseAuthException catch (e) {
      return left(_handleFirebaseAuthException(e));
    } on PlatformException catch (e) {
      return left(_handlePlatformException(e));
    }
  }

  Future<Either<AuthFailure, Unit>> verifyEmail({
    required String actionCode,
  }) async {
    try {
      await _firebaseAuth.applyActionCode(actionCode);
      return right(unit);
    } on FirebaseAuthException catch (e) {
      return left(_handleFirebaseAuthException(e));
    } on PlatformException catch (e) {
      return left(_handlePlatformException(e));
    }
  }

  Future<Either<AuthFailure, AuthUser>> signInWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: emailAddress.getOrCrash(),
        password: password.getOrCrash(),
      );
      final user = credential.user;
      if (user == null) {
        return left(const AuthFailure.serverError());
      }

      final authUser = AuthUser(
        id: UniqueId.fromUniqueString(user.uid),
        name: user.displayName != null ? Name(user.displayName!) : null,
        email: EmailAddress(user.email!),
        isEmailVerified: user.emailVerified,
        photoUrl: user.photoURL != null ? Url(user.photoURL!) : null,
      );

      return authUser.failureOption.fold(
        () => right(authUser),
        (failure) => failure.maybeMap(
          orElse: () => left(const AuthFailure.serverError()),
        ),
      );
    } on FirebaseAuthException catch (e) {
      return left(_handleFirebaseAuthException(e));
    } on PlatformException catch (e) {
      return left(_handlePlatformException(e));
    }
  }

  Future<Either<AuthFailure, AuthUser>> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return left(const AuthFailure.cancelledByUser());
      }

      final googleAuthentication = await googleUser.authentication;
      final authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuthentication.accessToken,
        idToken: googleAuthentication.idToken,
      );

      final credential =
          await _firebaseAuth.signInWithCredential(authCredential);
      final user = credential.user;
      if (user == null) {
        return left(const AuthFailure.serverError());
      }

      final authUser = AuthUser(
        id: UniqueId.fromUniqueString(user.uid),
        name: Name(user.displayName!),
        email: EmailAddress(user.email!),
        isEmailVerified: user.emailVerified,
        photoUrl: user.photoURL != null ? Url(user.photoURL!) : null,
      );

      return authUser.failureOption.fold(
        () => right(authUser),
        (failure) => failure.maybeMap(
          orElse: () => left(const AuthFailure.serverError()),
        ),
      );
    } on FirebaseAuthException catch (e) {
      return left(_handleFirebaseAuthException(e));
    } on PlatformException catch (e) {
      return left(_handlePlatformException(e));
    }
  }

  Future<void> reloadUser() async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      await user.reload();
    }
  }

  AuthFailure _handleFirebaseAuthException(FirebaseAuthException e) {
    log('FirebaseAuthException: ${e.code}');
    switch (e.code) {
      case 'invalid-email':
        return const AuthFailure.invalidEmail();
      case 'email-already-in-use':
        return const AuthFailure.emailAlreadyInUse();
      case 'weak-password':
        return const AuthFailure.invalidPassword();
      case 'user-disabled':
        return const AuthFailure.userDisabled();
      case 'user-not-found':
        return const AuthFailure.userNotFound();
      case 'wrong-password':
        return const AuthFailure.invalidPassword();
      case 'account-exists-with-different-credential':
        return const AuthFailure.accountExistsWithDifferentCredential();
      case 'invalid-credential':
        return const AuthFailure.invalidCredential();
      case 'operation-not-allowed':
        return const AuthFailure.operationNotAllowed();
      case 'invalid-verification-code':
        return const AuthFailure.invalidVerificationCode();
      case 'expired-action-code':
        return const AuthFailure.expiredActionCode();
      case 'invalid-action-code':
        return const AuthFailure.invalidActionCode();
      case 'invalid-phone-number':
        return const AuthFailure.invalidPhoneNumber();
      case 'invalid-verification-id':
        return const AuthFailure.invalidVerificationId();
      case 'auth/invalid-email':
        return const AuthFailure.invalidEmail();
      case 'auth/user-not-found':
        return const AuthFailure.userNotFound();
      default:
        return const AuthFailure.serverError();
    }
  }

  AuthFailure _handlePlatformException(PlatformException e) {
    if (e.code == 'ERROR_USER_DISABLED') {
      return const AuthFailure.userDisabled();
    } else {
      return const AuthFailure.serverError();
    }
  }

  Future<void> signOut() {
    return Future.wait([
      _googleSignIn.signOut(),
      _firebaseAuth.signOut(),
    ]);
  }
}
