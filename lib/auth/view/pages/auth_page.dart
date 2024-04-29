import 'package:climate_confluence/core/router/router.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              width: 200,
              height: 200,
              child: Placeholder(),
            ),
            const SizedBox(height: 16),
            const Text('Welcome to Climate Confluence'),
            const SizedBox(height: 16),
            FilledButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  Theme.of(context).colorScheme.primary,
                ),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              onPressed: () {
                const SignUpRoute().push<SignUpRoute>(context);
              },
              child: const Text('Create an account'),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              style: ButtonStyle(
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              onPressed: () {
                const SignInRoute().push<SignInRoute>(context);
              },
              child: const Text('Sign in'),
            ),
          ],
        ),
      ),
    );
  }
}
