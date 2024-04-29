import 'package:climate_confluence/auth/bloc/auth_bloc.dart';
import 'package:climate_confluence/auth/bloc/sign_in_form/sign_in_form_bloc.dart';
import 'package:climate_confluence/auth/bloc/sign_up_form/sign_up_form_bloc.dart';
import 'package:climate_confluence/core/di/injection.dart';
import 'package:climate_confluence/core/router/router.dart';
import 'package:climate_confluence/user/bloc/user_cubit.dart';
import 'package:climate_confluence/user/bloc/user_form/user_form_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) =>
              getIt<AuthBloc>()..add(const AuthEvent.authCheckRequested()),
        ),
        BlocProvider<SignUpFormBloc>(
          create: (context) => getIt<SignUpFormBloc>(),
        ),
        BlocProvider<SignInFormBloc>(
          create: (context) => getIt<SignInFormBloc>(),
        ),
        // BlocProvider<EmailVerificationBloc>(
        //   create: (context) => getIt<EmailVerificationBloc>(),
        // ),
        BlocProvider<UserCubit>(
          create: (context) => getIt<UserCubit>(),
        ),
        BlocProvider<UserFormBloc>(
          create: (context) => getIt<UserFormBloc>(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
      ),
    );
  }
}
