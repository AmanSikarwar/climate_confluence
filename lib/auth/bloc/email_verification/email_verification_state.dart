part of 'email_verification_bloc.dart';

@freezed
abstract class EmailVerificationState with _$EmailVerificationState {
  const factory EmailVerificationState({
    required bool verified,
    required Option<Either<AuthFailure, Unit>> authFailureOrSuccessOption,
    DateTime? lastEmailSentTime,
  }) = _EmailVerificationState;

  factory EmailVerificationState.initial() => EmailVerificationState(
        verified: false,
        authFailureOrSuccessOption: none(),
      );
}
