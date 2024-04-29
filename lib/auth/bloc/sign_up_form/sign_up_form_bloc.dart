import 'package:bloc/bloc.dart';
import 'package:climate_confluence/auth/bloc/auth_bloc.dart';
import 'package:climate_confluence/auth/data/models/auth_failure.dart';
import 'package:climate_confluence/auth/data/models/auth_user.dart';
import 'package:climate_confluence/auth/data/repositories/firebase_auth_repo.dart';
import 'package:climate_confluence/common/data/models/value_objects.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'sign_up_form_bloc.freezed.dart';
part 'sign_up_form_event.dart';
part 'sign_up_form_state.dart';

@injectable
class SignUpFormBloc extends Bloc<SignUpFormEvent, SignUpFormState> {
  SignUpFormBloc(this._firebaseAuthRepo, this._authBloc)
      : super(SignUpFormState.initial()) {
    on<SignUpFormEvent>(
      (event, emit) async {
        switch (event) {
          case EmailChanged(:final emailStr):
            final emailAddress = EmailAddress(emailStr);
            emit(
              state.copyWith(
                emailAddress: emailAddress,
                authFailureOrSuccessOption: none(),
              ),
            );
          case PasswordChanged(:final passwordStr):
            final password = Password(passwordStr);
            emit(
              state.copyWith(
                password: password,
                authFailureOrSuccessOption: none(),
              ),
            );
          case ConfirmPasswordChanged(:final confirmPasswordStr):
            final confirmPassword = Password(confirmPasswordStr);
            emit(
              state.copyWith(
                confirmPassword: confirmPassword,
                authFailureOrSuccessOption: none(),
              ),
            );
          case RegisterWithEmailAndPasswordPressed():
            final emailAddress = state.emailAddress;
            final password = state.password;
            emit(
              state.copyWith(
                isSubmitting: true,
                showErrorMessage: true,
                authFailureOrSuccessOption: none(),
              ),
            );
            if (emailAddress.isValid() &&
                password.isValid() &&
                password == state.confirmPassword) {
              await _firebaseAuthRepo
                  .registerWithEmailAndPassword(
                emailAddress: emailAddress,
                password: password,
              )
                  .then(
                (failureOrUser) {
                  emit(
                    state.copyWith(
                      isSubmitting: false,
                      authFailureOrSuccessOption: some(failureOrUser),
                    ),
                  );
                },
              );
            }
            emit(
              state.copyWith(
                isSubmitting: false,
                authFailureOrSuccessOption: none(),
              ),
            );
            _authBloc.add(const AuthCheckRequested());
          case SignInWithGooglePressed():
            emit(
              state.copyWith(
                isSubmitting: true,
                authFailureOrSuccessOption: none(),
              ),
            );
            await _firebaseAuthRepo.signInWithGoogle().then(
              (failureOrUser) {
                emit(
                  state.copyWith(
                    isSubmitting: false,
                    authFailureOrSuccessOption: some(failureOrUser),
                  ),
                );
              },
            );
            _authBloc.add(const AuthCheckRequested());
        }
      },
    );
  }

  final FirebaseAuthRepo _firebaseAuthRepo;
  final AuthBloc _authBloc;
}
