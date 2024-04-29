import 'package:auth_buttons/auth_buttons.dart';
import 'package:climate_confluence/auth/bloc/sign_up_form/sign_up_form_bloc.dart';
import 'package:climate_confluence/core/router/router.dart';
import 'package:climate_confluence/user/bloc/user_cubit.dart';
import 'package:climate_confluence/user/view/utils/profile_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toasty_box/toasty_box.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _authChecked = false;
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SignUpFormBloc, SignUpFormState>(
          listener: (context, state) => state.authFailureOrSuccessOption.fold(
            () {},
            (either) => either.fold(
              (failure) => failure.maybeMap(
                accountExistsWithDifferentCredential: (_) =>
                    ToastService.showErrorToast(
                  context,
                  message: 'Account exists with different credentials',
                ),
                cancelledByUser: (_) => ToastService.showErrorToast(
                  context,
                  message: 'Sign In Cancelled',
                ),
                operationNotAllowed: (_) => ToastService.showErrorToast(
                  context,
                  message: 'Operation not allowed',
                ),
                emailAlreadyInUse: (_) => ToastService.showErrorToast(
                  context,
                  message: 'Email already in use',
                ),
                orElse: () => ToastService.showErrorToast(
                  context,
                  message: 'An unexpected error occurred',
                ),
              ),
              (user) {
                ToastService.showSuccessToast(
                  context,
                  message: 'Sign Up Successful',
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
      child: BlocBuilder<SignUpFormBloc, SignUpFormState>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: const Text('Sign Up'),
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
                  onChanged: (email) =>
                      context.read<SignUpFormBloc>().add(EmailChanged(email)),
                  validator: (_) => context
                      .read<SignUpFormBloc>()
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
                      .read<SignUpFormBloc>()
                      .add(PasswordChanged(password)),
                  validator: (_) =>
                      context.read<SignUpFormBloc>().state.password.value.fold(
                            (f) => f.maybeMap(
                              empty: (_) => 'Password cannot be empty',
                              shortLength: (_) => 'Password is too short',
                              orElse: () => null,
                            ),
                            (_) => null,
                          ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  onChanged: (password) {
                    context
                        .read<SignUpFormBloc>()
                        .add(ConfirmPasswordChanged(password));
                  },
                  validator: (_) => context
                      .read<SignUpFormBloc>()
                      .state
                      .confirmPassword
                      .value
                      .fold(
                        (f) => f.maybeMap(
                          empty: (_) => 'Password cannot be empty',
                          shortLength: (_) => 'Password is too short',
                          orElse: () => 'Passwords do not match',
                        ),
                        (value) => value !=
                                context
                                    .read<SignUpFormBloc>()
                                    .state
                                    .password
                                    .value
                                    .getOrElse((_) => '')
                            ? 'Passwords do not match'
                            : null,
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
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (!state.isSubmitting) {
                      context.read<SignUpFormBloc>().add(
                            const RegisterWithEmailAndPasswordPressed(),
                          );
                    }
                  },
                  child: Text(state.isSubmitting ? 'Signing Up...' : 'Sign Up'),
                ),
                const SizedBox(height: 8),
                GoogleAuthButton(
                  style: const AuthButtonStyle(
                    borderRadius: 24,
                    height: 48,
                  ),
                  isLoading: state.isSubmitting,
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    context
                        .read<SignUpFormBloc>()
                        .add(const SignInWithGooglePressed());
                  },
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Already have an account?'),
                    TextButton(
                      onPressed: () =>
                          const SignInRoute().push<SignInRoute>(context),
                      child: const Text('Sign In'),
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
