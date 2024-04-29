part of 'sign_up_form_bloc.dart';

@freezed
sealed class SignUpFormEvent with _$SignUpFormEvent {
  const factory SignUpFormEvent.emailChanged(String emailStr) = EmailChanged;
  const factory SignUpFormEvent.passwordChanged(String passwordStr) =
      PasswordChanged;
  const factory SignUpFormEvent.confirmPasswordChanged(
    String confirmPasswordStr,
  ) = ConfirmPasswordChanged;
  const factory SignUpFormEvent.registerWithEmailAndPasswordPressed() =
      RegisterWithEmailAndPasswordPressed;
  const factory SignUpFormEvent.signInWithGooglePressed() =
      SignInWithGooglePressed;
}
