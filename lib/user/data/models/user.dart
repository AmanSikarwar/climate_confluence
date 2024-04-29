import 'package:climate_confluence/auth/data/models/auth_user.dart';
import 'package:climate_confluence/common/data/models/failures.dart';
import 'package:climate_confluence/common/data/models/value_objects.dart';
import 'package:climate_confluence/user/data/models/value_objects.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
abstract class User with _$User {
  const factory User({
    required UniqueId id,
    required Name name,
    required Gender gender,
    required EmailAddress emailAddress,
    required PhoneNumber phoneNumber,
    required SchoolName schoolName,
    required EducationalQualification educationalQualification,
    required City city,
    required IndianStatesAndUnionTerritories state,
    required DateTime createdAt,
    required DateTime updatedAt,
    Url? photoUrl,
    UserBio? bio,
  }) = _User;

  factory User.empty() => User(
        id: UniqueId(),
        name: Name(' '),
        gender: Gender.unknown,
        emailAddress: EmailAddress(''),
        phoneNumber: PhoneNumber(''),
        schoolName: SchoolName(''),
        educationalQualification: EducationalQualification.unknown,
        city: City(''),
        state: IndianStatesAndUnionTerritories.unknown,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

  factory User.fromAuthUser(AuthUser authUser) {
    return User(
      id: authUser.id,
      name: authUser.name ?? Name(''),
      gender: Gender.unknown,
      emailAddress: authUser.email,
      phoneNumber: PhoneNumber(''),
      schoolName: SchoolName(''),
      educationalQualification: EducationalQualification.unknown,
      photoUrl: authUser.photoUrl,
      bio: UserBio.empty(),
      city: City(''),
      state: IndianStatesAndUnionTerritories.unknown,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}

extension UserX on User {
  Option<ValueFailure<dynamic>> get failureOption {
    return name.failureOrUnit
        .andThen(() => emailAddress.failureOrUnit)
        .andThen(() => phoneNumber.failureOrUnit)
        .andThen(() => schoolName.failureOrUnit)
        .andThen(() => city.failureOrUnit)
        .fold(
          some,
          (_) => none(),
        );
  }
}
