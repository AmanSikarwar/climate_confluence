import 'package:auth_buttons/auth_buttons.dart';
import 'package:climate_confluence/auth/bloc/sign_in_form/sign_in_form_bloc.dart';
import 'package:climate_confluence/core/router/router.dart';
import 'package:climate_confluence/user/bloc/user_cubit.dart';
import 'package:climate_confluence/user/view/utils/profile_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toasty_box/toasty_box.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _authChecked = false;
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SignInFormBloc, SignInFormState>(
          listener: (context, state) => state.authFailureOrSuccessOption.fold(
            () {},
            (either) => either.fold(
              (failure) => failure.maybeMap(
                invalidEmailAndPasswordCombination: (_) =>
                    ToastService.showErrorToast(
                  context,
                  message: 'Invalid email and password combination',
                ),
                cancelledByUser: (_) => ToastService.showErrorToast(
                  context,
                  message: 'Sign In Cancelled',
                ),
                operationNotAllowed: (_) => ToastService.showErrorToast(
                  context,
                  message: 'Operation not allowed',
                ),
                invalidCredential: (_) => ToastService.showErrorToast(
                  context,
                  message: 'Invalid credential',
                ),
                orElse: () => ToastService.showErrorToast(
                  context,
                  message: 'An unexpected error occurred',
                ),
              ),
              (user) {
                ToastService.showSuccessToast(
                  context,
                  message: 'Sign In Successful',
                );
                if (!user.isEmailVerified) {
                  const EmailVerificationRoute().go(context);
                } else {
                  _authChecked = true;
                  context.read<UserCubit>().fetchUser();
                }
              },
            ),
          ),
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
      child: BlocBuilder<SignInFormBloc, SignInFormState>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: const Text('Sign In'),
          ),
          body: Form(
            autovalidateMode: state.showErrorMessage
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: <Widget>[
                if (state.isSubmitting) ...[
                  const LinearProgressIndicator(),
                ],
                const SizedBox(height: 16),
                const SizedBox(
                  width: 100,
                  height: 100,
                  child: Placeholder(),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (email) {
                    context.read<SignInFormBloc>().add(EmailChanged(email));
                  },
                  validator: (_) => context
                      .read<SignInFormBloc>()
                      .state
                      .emailAddress
                      .value
                      .fold(
                        (f) => f.maybeMap(
                          invalidEmail: (_) => 'Invalid email',
                          orElse: () => null,
                        ),
                        (_) => null,
                      ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () => setState(
                        () => _isPasswordVisible = !_isPasswordVisible,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !_isPasswordVisible,
                  onChanged: (password) => context
                      .read<SignInFormBloc>()
                      .add(PasswordChanged(password)),
                  validator: (_) =>
                      context.read<SignInFormBloc>().state.password.value.fold(
                            (f) => f.maybeMap(
                              empty: (_) => 'Password cannot be empty',
                              shortLength: (_) => 'Password is too short',
                              orElse: () => null,
                            ),
                            (_) => null,
                          ),
                ),
                const SizedBox(height: 16),
                FilledButton(
                  style: ButtonStyle(
                    minimumSize: WidgetStateProperty.all(
                      const Size(double.infinity, 48),
                    ),
                    textStyle: WidgetStateProperty.all(
                      const TextStyle(fontSize: 20),
                    ),
                  ),
                  onPressed: () => !state.isSubmitting
                      ? context
                          .read<SignInFormBloc>()
                          .add(const SignInWithEmailAndPasswordPressed())
                      : null,
                  child: Text(state.isSubmitting ? 'Signing In...' : 'Sign In'),
                ),
                const SizedBox(height: 16),
                GoogleAuthButton(
                  style: const AuthButtonStyle(
                    borderRadius: 24,
                    height: 48,
                  ),
                  isLoading: state.isSubmitting,
                  onPressed: () => context
                      .read<SignInFormBloc>()
                      .add(const SignInWithGooglePressed()),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Forgot your password?'),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Reset it'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
