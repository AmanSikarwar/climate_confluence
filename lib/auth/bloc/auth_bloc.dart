import 'package:bloc/bloc.dart';
import 'package:climate_confluence/auth/data/models/auth_failure.dart';
import 'package:climate_confluence/auth/data/models/auth_user.dart';
import 'package:climate_confluence/auth/data/repositories/firebase_auth_repo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

@lazySingleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required FirebaseAuthRepo authRepo})
      : _authRepo = authRepo,
        super(const Initial()) {
    on<AuthEvent>((events, emit) async {
      switch (events) {
        case AuthCheckRequested _:
          final userOption = _authRepo.getSignedInUser();
          emit(
            userOption.fold(
              () => const AuthState.unauthenticated(),
              AuthState.authenticated,
            ),
          );
        case SignedOut _:
          await _authRepo.signOut();
          emit(const AuthState.unauthenticated());
      }
    });
  }

  final FirebaseAuthRepo _authRepo;
}
