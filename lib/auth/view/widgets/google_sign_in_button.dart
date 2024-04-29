// import 'package:auth_buttons/auth_buttons.dart';
// import 'package:climate_confluence/auth/bloc/sign_in_form/sign_in_form_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class GoogleSignInButton extends StatelessWidget {
//   const GoogleSignInButton(this.size, {super.key});
//   final Size size;
//   final VoidCallback onPressed;
//   final bool isLoading;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 32,
//         vertical: 16,
//       ),
//       child: BlocBuilder<SignInFormBloc, SignInFormState>(
//         builder: (context, state) {
//           return GoogleAuthButton(
//             onPressed: onPressed,
//             isLoading: isLoading,
//             style: AuthButtonStyle(
//               elevation: 4,
//               width: size.width,
//               height: 56,
//               progressIndicatorValueColor:
//                   Theme.of(context).colorScheme.onPrimary,
//               progressIndicatorColor: Theme.of(context).colorScheme.primary,
//               borderRadius: 16,
//               visualDensity: VisualDensity.standard,
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
