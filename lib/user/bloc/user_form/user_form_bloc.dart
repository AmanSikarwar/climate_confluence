import 'package:bloc/bloc.dart';
import 'package:climate_confluence/common/data/models/value_objects.dart';
import 'package:climate_confluence/user/bloc/user_cubit.dart';
import 'package:climate_confluence/user/data/models/user.dart';
import 'package:climate_confluence/user/data/models/user_failure.dart';
import 'package:climate_confluence/user/data/models/value_objects.dart';
import 'package:climate_confluence/user/data/repositories/user_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'user_form_event.dart';
part 'user_form_state.dart';

part 'user_form_bloc.freezed.dart';

@injectable
class UserFormBloc extends Bloc<UserFormEvent, UserFormState> {
  UserFormBloc(this._userRepository, this._userCubit)
      : super(UserFormState.initial()) {
    on<UserFormEvent>((event, emit) async {
      switch (event) {
        case Initialized(:final isEditing, :final user):
          late final User initialUser;
          if (user != null) {
            initialUser = user;
          } else {
            initialUser = (isEditing
                    ? await _userRepository.getCurrentUser()
                    : await _userRepository.getInitialUserFromAuth())
                .toNullable()!;
          }
          emit(
            state.copyWith(
              user: initialUser,
              isEditing: isEditing,
              showErrorMessages: false,
              isSaving: false,
              saveFailureOrSuccessOption: none(),
            ),
          );
        case NameChanged(:final nameStr):
          emit(
            state.copyWith(
              user: state.user.copyWith(
                name: Name(nameStr),
              ),
              saveFailureOrSuccessOption: none(),
            ),
          );
        case PhotoUrlChanged(:final photoUrlStr):
          emit(
            state.copyWith(
              user: state.user.copyWith(
                photoUrl: Url(photoUrlStr),
              ),
              saveFailureOrSuccessOption: none(),
            ),
          );
        case BioChanged(:final bioStr):
          emit(
            state.copyWith(
              user: state.user.copyWith(
                bio: UserBio(bioStr),
              ),
              saveFailureOrSuccessOption: none(),
            ),
          );
        case Saved():
          Either<UserFailure, Unit>? failureOrSuccess;

          emit(
            state.copyWith(
              isSaving: true,
              saveFailureOrSuccessOption: none(),
            ),
          );

          if (state.user.failureOption.isNone()) {
            failureOrSuccess = state.isEditing
                ? await _userRepository.updateUser(state.user)
                : await _userRepository.createUser(state.user);
          }

          emit(
            state.copyWith(
              isSaving: false,
              showErrorMessages: true,
              saveFailureOrSuccessOption: optionOf(failureOrSuccess),
            ),
          );
          if (failureOrSuccess != null && failureOrSuccess.isRight()) {
            await _userCubit.fetchUser();
          }
        case PhoneNumberChanged(:final phoneNumberStr):
          emit(
            state.copyWith(
              user: state.user.copyWith(
                phoneNumber: PhoneNumber(phoneNumberStr),
              ),
              saveFailureOrSuccessOption: none(),
            ),
          );
        case SchoolNameChanged(:final schoolNameStr):
          emit(
            state.copyWith(
              user: state.user.copyWith(
                schoolName: SchoolName(schoolNameStr),
              ),
              saveFailureOrSuccessOption: none(),
            ),
          );
        case EducationalQualificationChanged(:final educationalQualification):
          emit(
            state.copyWith(
              user: state.user.copyWith(
                educationalQualification: educationalQualification,
              ),
              saveFailureOrSuccessOption: none(),
            ),
          );
        case CityChanged(:final cityStr):
          emit(
            state.copyWith(
              user: state.user.copyWith(
                city: City(cityStr),
              ),
              saveFailureOrSuccessOption: none(),
            ),
          );
        case StateChanged(:final stateOrUnionTerotory):
          emit(
            state.copyWith(
              user: state.user.copyWith(
                state: stateOrUnionTerotory,
              ),
              saveFailureOrSuccessOption: none(),
            ),
          );
        case GenderChanged(:final gender):
          emit(
            state.copyWith(
              user: state.user.copyWith(
                gender: gender,
              ),
              saveFailureOrSuccessOption: none(),
            ),
          );
      }
    });
  }

  final UserRepository _userRepository;
  final UserCubit _userCubit;
}
