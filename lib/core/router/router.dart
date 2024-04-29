import 'package:climate_confluence/auth/view/pages/auth_page.dart';
import 'package:climate_confluence/auth/view/pages/email_verification_page.dart';
import 'package:climate_confluence/auth/view/pages/sign_in_page.dart';
import 'package:climate_confluence/auth/view/pages/sign_up_page.dart';
import 'package:climate_confluence/common/view/pages/home_page.dart';
import 'package:climate_confluence/splash/view/splash_page.dart';
import 'package:climate_confluence/user/view/pages/profile_page.dart';
import 'package:climate_confluence/user/view/utils/profile_actions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'router.g.dart';

const initialLocation = '/';
const authLocation = '/auth';
const signInLocation = '/auth/sign_in';
const signUpLocation = '/auth/sign_up';
const emailVerificationLocation = '/auth/email_verification';
const homeLocation = '/home';
const frofileLocation = '/profile';

final router = GoRouter(
  routes: $appRoutes,
  initialLocation: initialLocation,
);

@TypedGoRoute<SplashRoute>(
  path: initialLocation,
)
class SplashRoute extends GoRouteData {
  const SplashRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const SplashPage();
}

@TypedGoRoute<AuthRoute>(
  path: authLocation,
)
class AuthRoute extends GoRouteData {
  const AuthRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const AuthPage();
}

@TypedGoRoute<SignInRoute>(
  path: signInLocation,
)
class SignInRoute extends GoRouteData {
  const SignInRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const SignInPage();
}

@TypedGoRoute<SignUpRoute>(
  path: signUpLocation,
)
class SignUpRoute extends GoRouteData {
  const SignUpRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const SignUpPage();
}

@TypedGoRoute<EmailVerificationRoute>(
  path: emailVerificationLocation,
)
class EmailVerificationRoute extends GoRouteData {
  const EmailVerificationRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const EmailVerificationPage();
}

@TypedGoRoute<HomeRoute>(
  path: homeLocation,
)
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomePage();
}

@TypedGoRoute<ProfileRoute>(
  path: frofileLocation,
)
class ProfileRoute extends GoRouteData {
  const ProfileRoute({
    this.action = ProfileAction.view,
  });
  final ProfileAction action;

  @override
  Widget build(BuildContext context, GoRouterState state) => ProfilePage(
        profileAction: action,
      );
}
