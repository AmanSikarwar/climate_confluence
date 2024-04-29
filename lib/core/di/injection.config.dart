// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:climate_confluence/auth/bloc/auth_bloc.dart' as _i8;
import 'package:climate_confluence/auth/bloc/email_verification/email_verification_bloc.dart'
    as _i11;
import 'package:climate_confluence/auth/bloc/sign_in_form/sign_in_form_bloc.dart'
    as _i9;
import 'package:climate_confluence/auth/bloc/sign_up_form/sign_up_form_bloc.dart'
    as _i10;
import 'package:climate_confluence/auth/data/repositories/firebase_auth_repo.dart'
    as _i7;
import 'package:climate_confluence/common/data/injectable_modules.dart' as _i15;
import 'package:climate_confluence/user/bloc/user_cubit.dart' as _i13;
import 'package:climate_confluence/user/bloc/user_form/user_form_bloc.dart'
    as _i14;
import 'package:climate_confluence/user/data/repositories/user_repository.dart'
    as _i12;
import 'package:cloud_firestore/cloud_firestore.dart' as _i5;
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:firebase_storage/firebase_storage.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i4;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final firebaseModules = _$FirebaseModules();
    gh.lazySingleton<_i3.FirebaseAuth>(() => firebaseModules.firebaseAuth);
    gh.lazySingleton<_i4.GoogleSignIn>(() => firebaseModules.googleSignIn);
    gh.lazySingleton<_i5.FirebaseFirestore>(() => firebaseModules.firestore);
    gh.lazySingleton<_i6.FirebaseStorage>(
        () => firebaseModules.firebaseStorage);
    gh.lazySingleton<_i7.FirebaseAuthRepo>(() => _i7.FirebaseAuthRepo(
          firebaseAuth: gh<_i3.FirebaseAuth>(),
          googleSignIn: gh<_i4.GoogleSignIn>(),
        ));
    gh.lazySingleton<_i8.AuthBloc>(
        () => _i8.AuthBloc(authRepo: gh<_i7.FirebaseAuthRepo>()));
    gh.factory<_i9.SignInFormBloc>(() => _i9.SignInFormBloc(
          gh<_i7.FirebaseAuthRepo>(),
          gh<_i8.AuthBloc>(),
        ));
    gh.factory<_i10.SignUpFormBloc>(() => _i10.SignUpFormBloc(
          gh<_i7.FirebaseAuthRepo>(),
          gh<_i8.AuthBloc>(),
        ));
    gh.factory<_i11.EmailVerificationBloc>(
        () => _i11.EmailVerificationBloc(gh<_i7.FirebaseAuthRepo>()));
    gh.lazySingleton<_i12.UserRepository>(() => _i12.UserRepository(
          authRepo: gh<_i7.FirebaseAuthRepo>(),
          firestore: gh<_i5.FirebaseFirestore>(),
        ));
    gh.factory<_i13.UserCubit>(() => _i13.UserCubit(gh<_i12.UserRepository>()));
    gh.factory<_i14.UserFormBloc>(() => _i14.UserFormBloc(
          gh<_i12.UserRepository>(),
          gh<_i13.UserCubit>(),
        ));
    return this;
  }
}

class _$FirebaseModules extends _i15.FirebaseModules {}
