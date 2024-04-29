part of 'email_verification_bloc.dart';

@freezed
sealed class EmailVerificationEvent with _$EmailVerificationEvent {
  const factory EmailVerificationEvent.verificationEmailSent() =
      VerificationEmailSent;
  const factory EmailVerificationEvent.authUserChanged(AuthUser authUser) =
      _AuthUserChanged;
  const factory EmailVerificationEvent.reSendVerificationEmailPressed() =
      ReSendVerificationEmailPressed;
}
