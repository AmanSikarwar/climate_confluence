import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:climate_confluence/auth/data/models/auth_failure.dart';
import 'package:climate_confluence/auth/data/models/auth_user.dart';
import 'package:climate_confluence/auth/data/repositories/firebase_auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'email_verification_bloc.freezed.dart';
part 'email_verification_event.dart';
part 'email_verification_state.dart';

@injectable
class EmailVerificationBloc
    extends Bloc<EmailVerificationEvent, EmailVerificationState> {
  EmailVerificationBloc(this._firebaseAuthRepo)
      : super(EmailVerificationState.initial()) {
    on<EmailVerificationEvent>(
      (event, emit) async {
        switch (event) {
          case VerificationEmailSent():
            final failureOption =
                await _firebaseAuthRepo.sendEmailVerification();
            emit(
              state.copyWith(
                lastEmailSentTime: DateTime.now(),
                authFailureOrSuccessOption: failureOption.fold(
                  (failure) => some(left(failure)),
                  (_) => some(right(unit)),
                ),
              ),
            );
            _onAuthStateChanged = _firebaseAuthRepo.onAuthStateChanged.listen(
              (either) {
                either.fold(
                  (failure) {
                    emit(
                      state.copyWith(
                        authFailureOrSuccessOption: some(left(failure)),
                      ),
                    );
                  },
                  (user) async {
                    add(_AuthUserChanged(user));
                    await _firebaseAuthRepo.reloadUser();
                  },
                );
              },
            );
          case ReSendVerificationEmailPressed():
            if (state.lastEmailSentTime != null &&
                DateTime.now().difference(state.lastEmailSentTime!) <
                    const Duration(seconds: 60)) {
              emit(
                state.copyWith(
                  authFailureOrSuccessOption: some(
                    left(
                      const AuthFailure.operationNotAllowed(),
                    ),
                  ),
                ),
              );
            } else {
              add(const VerificationEmailSent());
            }
          case _AuthUserChanged(:final authUser):
            emit(
              state.copyWith(
                verified: authUser.isEmailVerified,
              ),
            );
        }
      },
      transformer: restartable(),
    );
  }

  @override
  Future<void> close() {
    _onAuthStateChanged?.cancel();
    return super.close();
  }

  StreamSubscription<Either<AuthFailure, AuthUser>>? _onAuthStateChanged;

  final FirebaseAuthRepo _firebaseAuthRepo;
}
