import 'package:climate_confluence/user/data/models/user.dart';
import 'package:climate_confluence/user/data/models/user_failure.dart';
import 'package:climate_confluence/user/data/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'user_state.dart';
part 'user_cubit.freezed.dart';

@injectable
class UserCubit extends Cubit<UserState> {
  UserCubit(this._userRepository) : super(const UserState.initial());
  final UserRepository _userRepository;

  Future<void> fetchUser() async {
    emit(const UserState.loadInProgress());
    final userOption = await _userRepository.getCurrentUser();
    userOption.fold(
      () => emit(const UserState.loadFailure(UserFailure.notFound())),
      (user) => emit(UserState.loadSuccess(user)),
    );
  }
}
