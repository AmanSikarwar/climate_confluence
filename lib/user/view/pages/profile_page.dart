import 'package:climate_confluence/core/di/injection.dart';
import 'package:climate_confluence/core/router/router.dart';
import 'package:climate_confluence/user/bloc/user_cubit.dart';
import 'package:climate_confluence/user/bloc/user_form/user_form_bloc.dart';
import 'package:climate_confluence/user/view/utils/profile_actions.dart';
import 'package:climate_confluence/user/view/widgets/profile_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    required this.profileAction,
    super.key,
  });

  final ProfileAction profileAction;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      bloc: getIt<UserCubit>()..fetchUser(),
      listener: (context, state) {
        state.maybeMap(
          loadSuccess: (_) => const HomeRoute().go(context),
          orElse: () {},
        );
      },
      builder: (context, state) {
        switch (profileAction) {
          case ProfileAction.create:
            context.read<UserFormBloc>().add(
                  const Initialized(
                    isEditing: false,
                  ),
                );
            return const ProfileForm(isEditing: false);
          case ProfileAction.edit:
            context.read<UserFormBloc>().add(
                  const Initialized(
                    isEditing: true,
                  ),
                );
            return const ProfileForm(isEditing: true);
          case ProfileAction.view:
            return Container();
        }
        // switch (state) {
        //   case LoadFailure(:final userFailure):
        //     if (userFailure is NotFound) {
        //       return BlocProvider(
        //         create: (context) => getIt<UserFormBloc>()
        //           ..add(
        //             const Initialized(
        //               isEditing: false,
        //             ),
        //           ),
        //         child: const ProfileForm(isEditing: false),
        //       );
        //     }
        //   case Initial():
        //   case LoadInProgress():
        //     return ColoredBox(
        //       color: Theme.of(context).canvasColor,
        //       child: const Center(
        //         child: CircularProgressIndicator(),
        //       ),
        //     );
        //   case LoadSuccess(:final user):
        //     return BlocProvider(
        //       create: (context) => getIt<UserFormBloc>()
        //         ..add(
        //           Initialized(
        //             isEditing: true,
        //             user: user,
        //           ),
        //         ),
        //       child: const ProfileForm(isEditing: true),
        //     );
        // }
      },
    );
  }
}
