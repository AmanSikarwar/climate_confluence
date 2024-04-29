import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_failure.freezed.dart';

@freezed
sealed class AuthFailure with _$AuthFailure {
  const factory AuthFailure.cancelledByUser() = CancelledByUser;
  const factory AuthFailure.emailAlreadyInUse() = EmailAlreadyInUse;
  const factory AuthFailure.invalidEmailAndPasswordCombination() =
      InvalidEmailAndPasswordCombination;
  const factory AuthFailure.invalidEmail() = InvalidEmail;
  const factory AuthFailure.invalidPassword() = InvalidPassword;

  const factory AuthFailure.serverError() = ServerError;
  const factory AuthFailure.accountExistsWithDifferentCredential() =
      AccountExistsWithDifferentCredential;
  const factory AuthFailure.invalidCredential() = InvalidCredential;
  const factory AuthFailure.userDisabled() = UserDisabled;
  const factory AuthFailure.userNotFound() = UserNotFound;
  const factory AuthFailure.operationNotAllowed() = OperationNotAllowed;
  const factory AuthFailure.invalidVerificationCode() = InvalidVerificationCode;
  const factory AuthFailure.invalidPhoneNumber() = InvalidPhoneNumber;
  const factory AuthFailure.invalidVerificationId() = InvalidVerificationId;
  const factory AuthFailure.expiredActionCode() = ExpiredActionCode;
  const factory AuthFailure.invalidActionCode() = InvalidActionCode;
}
