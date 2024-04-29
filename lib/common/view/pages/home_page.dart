import 'package:climate_confluence/auth/bloc/auth_bloc.dart';
import 'package:climate_confluence/core/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home Page'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<AuthBloc>().add(const AuthEvent.signedOut());
                const AuthRoute().go(context);
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
