import 'package:climate_confluence/common/data/models/failures.dart';
import 'package:climate_confluence/common/data/models/value_objects.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_user.freezed.dart';

@freezed
abstract class AuthUser with _$AuthUser {
  factory AuthUser({
    required UniqueId id,
    required EmailAddress email,
    required bool isEmailVerified,
    Name? name,
    Url? photoUrl,
  }) = _AuthUser;
}

extension AuthUserX on AuthUser {
  Option<ValueFailure<dynamic>> get failureOption {
    return email.failureOrUnit
        .andThen(
          () => (name != null ? name!.failureOrUnit : Either.of(unit)),
        )
        .andThen(
          () => (photoUrl != null ? photoUrl!.failureOrUnit : Either.of(unit)),
        )
        .fold(
          some,
          (r) => const None(),
        );
  }
}
