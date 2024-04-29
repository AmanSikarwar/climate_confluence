import 'package:bloc/bloc.dart';
import 'package:climate_confluence/auth/bloc/auth_bloc.dart';
import 'package:climate_confluence/auth/data/models/auth_failure.dart';
import 'package:climate_confluence/auth/data/models/auth_user.dart';
import 'package:climate_confluence/auth/data/repositories/firebase_auth_repo.dart';
import 'package:climate_confluence/common/data/models/value_objects.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'sign_in_form_bloc.freezed.dart';
part 'sign_in_form_event.dart';
part 'sign_in_form_state.dart';

@injectable
class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {
  SignInFormBloc(this._firebaseAuthRepo, this._authBloc)
      : super(SignInFormState.initial()) {
    on<SignInFormEvent>(
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
          case SignInWithEmailAndPasswordPressed():
            final emailAddress = state.emailAddress;
            final password = state.password;
            emit(
              state.copyWith(
                isSubmitting: true,
                showErrorMessage: true,
                authFailureOrSuccessOption: none(),
              ),
            );
            if (emailAddress.isValid() && password.isValid()) {
              await _firebaseAuthRepo
                  .signInWithEmailAndPassword(
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
            _authBloc.add(const AuthEvent.authCheckRequested());
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
            _authBloc.add(const AuthEvent.authCheckRequested());
        }
      },
    );
  }

  final FirebaseAuthRepo _firebaseAuthRepo;
  final AuthBloc _authBloc;
}
