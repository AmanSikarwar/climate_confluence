import 'package:climate_confluence/auth/bloc/email_verification/email_verification_bloc.dart';
import 'package:climate_confluence/core/di/injection.dart';
import 'package:climate_confluence/core/router/router.dart';
import 'package:climate_confluence/user/bloc/user_cubit.dart';
import 'package:climate_confluence/user/view/utils/profile_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toasty_box/toasty_box.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({super.key});

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  bool _verified = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EmailVerificationBloc>()
        ..add(
          const EmailVerificationEvent.verificationEmailSent(),
        ),
      child: Builder(
        builder: (context) {
          return MultiBlocListener(
            listeners: [
              BlocListener<EmailVerificationBloc, EmailVerificationState>(
                listener: (context, state) {
                  if (state.verified) {
                    ToastService.showSuccessToast(
                      context,
                      message: 'Email verified successfully',
                    );
                    _verified = true;
                    context.read<UserCubit>().fetchUser();
                  }
                  state.authFailureOrSuccessOption.fold(
                    () {},
                    (either) => either.fold(
                      (failure) {
                        failure.maybeMap(
                          expiredActionCode: (_) => ToastService.showErrorToast(
                            context,
                            message: 'Expired verification code',
                          ),
                          invalidActionCode: (_) => ToastService.showErrorToast(
                            context,
                            message: 'Invalid verification code',
                          ),
                          invalidVerificationCode: (_) =>
                              ToastService.showErrorToast(
                            context,
                            message: 'Invalid verification code',
                          ),
                          operationNotAllowed: (_) =>
                              ToastService.showErrorToast(
                            context,
                            message: 'Operation not allowed',
                          ),
                          orElse: () => ToastService.showErrorToast(
                            context,
                            message: 'An unexpected error occurred',
                          ),
                        );
                      },
                      (_) {},
                    ),
                  );
                },
              ),
              BlocListener<UserCubit, UserState>(
                listener: (context, state) {
                  if (_verified) {
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
            child: BlocBuilder<EmailVerificationBloc, EmailVerificationState>(
              builder: (context, state) {
                return Scaffold(
                  appBar: AppBar(
                    title: const Text('Email Verification'),
                  ),
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 16),
                      const Text(
                        '''
A verification email has been sent to your 
                        email address''',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (state.lastEmailSentTime != null &&
                              state.lastEmailSentTime!.isBefore(
                                DateTime.now().subtract(
                                  const Duration(minutes: 1),
                                ),
                              )) ...[
                            const Text("Didn't receive the Email?"),
                            TextButton(
                              onPressed: () {
                                context.read<EmailVerificationBloc>().add(
                                      const EmailVerificationEvent
                                          .reSendVerificationEmailPressed(),
                                    );
                              },
                              child: const Text('Resend'),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
