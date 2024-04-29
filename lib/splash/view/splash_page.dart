import 'package:climate_confluence/auth/bloc/auth_bloc.dart';
import 'package:climate_confluence/core/router/router.dart';
import 'package:climate_confluence/user/bloc/user_cubit.dart';
import 'package:climate_confluence/user/view/utils/profile_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _authChecked = false;
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            state.maybeMap(
              authenticated: (state) {
                if (!state.user.isEmailVerified) {
                  return const EmailVerificationRoute().go(context);
                } else {
                  _authChecked = true;
                  context.read<UserCubit>().fetchUser();
                }
              },
              unauthenticated: (_) {
                const AuthRoute().go(context);
              },
              orElse: () {},
            );
          },
        ),
        BlocListener<UserCubit, UserState>(
          listener: (BuildContext context, UserState state) {
            if (_authChecked) {
              state.maybeMap(
                loadFailure: (failure) {
                  failure.userFailure.maybeMap(
                    notFound: (_) {
                      const ProfileRoute(action: ProfileAction.create)
                          .go(context);
                    },
                    orElse: () {},
                  );
                },
                loadSuccess: (_) => const HomeRoute().go(context),
                orElse: () {},
              );
            }
          },
        ),
      ],
      child: const Scaffold(
        body: Center(
          child: SizedBox(
            width: 200,
            height: 200,
            child: Placeholder(),
          ),
        ),
      ),
    );
  }
}
