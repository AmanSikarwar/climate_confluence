import 'package:climate_confluence/user/bloc/user_form/user_form_bloc.dart';
import 'package:climate_confluence/user/data/models/value_objects.dart';
import 'package:climate_confluence/user/view/widgets/profile_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ProfileForm extends StatelessWidget {
  const ProfileForm({
    required this.isEditing,
    super.key,
  });

  final bool isEditing;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<UserFormBloc, UserFormState>(
          buildWhen: (previous, current) =>
              previous.isEditing != current.isEditing,
          builder: (context, state) {
            return Text(
              state.isEditing ? 'Edit Profile' : 'Create Profile',
            );
          },
        ),
        actions: [
          BlocBuilder<UserFormBloc, UserFormState>(
            buildWhen: (previous, current) =>
                previous.isEditing != current.isEditing,
            builder: (context, state) {
              return TextButton.icon(
                label: Text(state.isEditing ? 'Save' : 'Create'),
                icon: const Icon(Icons.check),
                onPressed: () {
                  context.read<UserFormBloc>().add(const Saved());
                },
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<UserFormBloc, UserFormState>(
        builder: (context, state) {
          return Form(
            autovalidateMode: state.showErrorMessages
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ProfilePhoto(
                  user: state.user,
                ),
                const SizedBox(height: 16),
                const NameFormField(),
                const SizedBox(height: 16),
                const GenderFormField(),
                const SizedBox(height: 16),
                const PhoneNumberFormField(),
                const SizedBox(height: 16),
                const SchoolNameFormField(),
                const SizedBox(height: 16),
                const EducationalQualificationFormField(),
                const SizedBox(height: 16),
                const CityFormField(),
                const SizedBox(height: 16),
                const StateFormField(),
                const SizedBox(height: 16),
                const BioFormField(),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.arrow_forward),
        onPressed: () {
          context.read<UserFormBloc>().add(const Saved());
        },
        label: const Text('Continue'),
      ),
    );
  }
}

class BioFormField extends HookWidget {
  const BioFormField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textEditingController = useTextEditingController();
    return BlocBuilder<UserFormBloc, UserFormState>(
      buildWhen: (previous, current) => previous.user.bio != current.user.bio,
      builder: (context, state) {
        return TextFormField(
          controller: textEditingController
            ..text = state.user.bio?.getOr('') ?? '',
          decoration: const InputDecoration(
            labelText: 'Bio',
            border: OutlineInputBorder(),
            hintText: 'Write a few sentences about yourself',
            alignLabelWithHint: true,
          ),
          autocorrect: false,
          maxLines: 3,
          onChanged: (value) =>
              context.read<UserFormBloc>().add(BioChanged(value)),
          validator: (_) =>
              context.read<UserFormBloc>().state.user.bio?.value.fold(
                    (f) => f.maybeMap(
                      empty: (_) => 'Cannot be empty',
                      exceedingLength: (_) => 'Exceeding length',
                      orElse: () => null,
                    ),
                    (_) => null,
                  ),
        );
      },
    );
  }
}

class NameFormField extends HookWidget {
  const NameFormField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textEditingController = useTextEditingController();
    return BlocConsumer<UserFormBloc, UserFormState>(
      listenWhen: (previous, current) =>
          previous.user.name != current.user.name,
      listener: (context, state) =>
          textEditingController.text = state.user.name.getOr(''),
      buildWhen: (previous, current) => previous.user.name != current.user.name,
      builder: (BuildContext context, UserFormState state) {
        return TextFormField(
          controller: textEditingController,
          decoration: const InputDecoration(
            labelText: 'Name',
            border: OutlineInputBorder(),
            hintText: 'Enter your name',
            alignLabelWithHint: true,
          ),
          onChanged: (value) => context.read<UserFormBloc>().add(
                NameChanged(value),
              ),
          validator: (_) =>
              context.read<UserFormBloc>().state.user.name.value.fold(
                    (f) => f.maybeMap(
                      empty: (_) => 'Cannot be empty',
                      exceedingLength: (_) => 'Exceeding length',
                      orElse: () => null,
                    ),
                    (_) => null,
                  ),
        );
      },
    );
  }
}

class GenderFormField extends StatelessWidget {
  const GenderFormField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserFormBloc, UserFormState>(
      buildWhen: (previous, current) =>
          previous.user.gender != current.user.gender,
      builder: (BuildContext context, UserFormState state) {
        return DropdownButtonFormField(
          decoration: const InputDecoration(
            labelText: 'Gender',
            border: OutlineInputBorder(),
          ),
          items: Gender.values.map(
            (e) {
              return DropdownMenuItem(
                value: e,
                child: Text(e.toString()),
              );
            },
          ).toList(),
          onChanged: (value) => context.read<UserFormBloc>().add(
                GenderChanged(value ?? Gender.unknown),
              ),
        );
      },
    );
  }
}

class PhoneNumberFormField extends StatelessWidget {
  const PhoneNumberFormField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserFormBloc, UserFormState>(
      buildWhen: (previous, current) =>
          previous.user.phoneNumber != current.user.phoneNumber,
      builder: (BuildContext context, UserFormState state) {
        return TextFormField(
          decoration: const InputDecoration(
            labelText: 'Phone Number',
            border: OutlineInputBorder(),
            hintText: 'Enter your phone number',
            alignLabelWithHint: true,
          ),
          keyboardType: TextInputType.phone,
          onChanged: (value) => context.read<UserFormBloc>().add(
                PhoneNumberChanged(value),
              ),
          validator: (_) =>
              context.read<UserFormBloc>().state.user.phoneNumber.value.fold(
                    (f) => f.maybeMap(
                      empty: (_) => 'Cannot be empty',
                      invalidPhoneNumber: (_) => 'Invalid phone number',
                      orElse: () => null,
                    ),
                    (_) => null,
                  ),
        );
      },
    );
  }
}

class SchoolNameFormField extends StatelessWidget {
  const SchoolNameFormField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserFormBloc, UserFormState>(
      buildWhen: (previous, current) =>
          previous.user.schoolName != current.user.schoolName,
      builder: (BuildContext context, UserFormState state) {
        return TextFormField(
          decoration: const InputDecoration(
            labelText: 'School/College Name',
            border: OutlineInputBorder(),
            hintText: 'Enter your school/college name',
            alignLabelWithHint: true,
          ),
          onChanged: (value) => context.read<UserFormBloc>().add(
                SchoolNameChanged(value),
              ),
          validator: (_) =>
              context.read<UserFormBloc>().state.user.schoolName.value.fold(
                    (f) => f.maybeMap(
                      empty: (_) => 'Cannot be empty',
                      exceedingLength: (_) => 'Exceeding length',
                      orElse: () => null,
                    ),
                    (_) => null,
                  ),
        );
      },
    );
  }
}

class EducationalQualificationFormField extends StatelessWidget {
  const EducationalQualificationFormField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserFormBloc, UserFormState>(
      buildWhen: (previous, current) =>
          previous.user.educationalQualification !=
          current.user.educationalQualification,
      builder: (BuildContext context, UserFormState state) {
        return DropdownButtonFormField(
          decoration: const InputDecoration(
            labelText: 'Educational Qualification',
            border: OutlineInputBorder(),
          ),
          items: EducationalQualification.values.map(
            (e) {
              return DropdownMenuItem(
                value: e,
                child: Text(e.toString()),
              );
            },
          ).toList(),
          onChanged: (value) => context.read<UserFormBloc>().add(
                EducationalQualificationChanged(
                  value ?? EducationalQualification.unknown,
                ),
              ),
        );
      },
    );
  }
}

class CityFormField extends StatelessWidget {
  const CityFormField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserFormBloc, UserFormState>(
      buildWhen: (previous, current) => previous.user.city != current.user.city,
      builder: (BuildContext context, UserFormState state) {
        return TextFormField(
          decoration: const InputDecoration(
            labelText: 'City',
            border: OutlineInputBorder(),
            hintText: 'Enter your city',
            alignLabelWithHint: true,
          ),
          onChanged: (value) => context.read<UserFormBloc>().add(
                CityChanged(value),
              ),
          validator: (_) =>
              context.read<UserFormBloc>().state.user.city.value.fold(
                    (f) => f.maybeMap(
                      empty: (_) => 'Cannot be empty',
                      exceedingLength: (_) => 'Exceeding length',
                      orElse: () => null,
                    ),
                    (_) => null,
                  ),
        );
      },
    );
  }
}

class StateFormField extends StatelessWidget {
  const StateFormField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserFormBloc, UserFormState>(
      buildWhen: (previous, current) =>
          previous.user.state != current.user.state,
      builder: (BuildContext context, UserFormState state) {
        return DropdownButtonFormField(
          decoration: const InputDecoration(
            labelText: 'State',
            border: OutlineInputBorder(),
          ),
          items: IndianStatesAndUnionTerritories.values.map(
            (e) {
              return DropdownMenuItem(
                value: e,
                child: Text(e.toString()),
              );
            },
          ).toList(),
          onChanged: (value) => context.read<UserFormBloc>().add(
                StateChanged(value ?? IndianStatesAndUnionTerritories.unknown),
              ),
        );
      },
    );
  }
}
